//
//  SignInVC.swift
//  devslopes-social
//
//  Created by Rao Noman on 10/29/17.
//  Copyright © 2017 Rao Noman. All rights reserved.
//

import UIKit
import FBSDKLoginKit
import FBSDKCoreKit
import Firebase
import SwiftKeychainWrapper

class SignInVC: UIViewController {

    @IBOutlet weak var pswdField: FancyFields!
    @IBOutlet weak var emailField: FancyFields!
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    //Disapear KeyBoard on view click
    override func viewDidAppear(_ animated: Bool) {
        if let _ = KeychainWrapper.standard.string(forKey: KEY_UID){
            performSegue(withIdentifier: "FeedVC", sender: nil)
        }
    }
    
    
    
    
    // Dismis key board when click outside the field
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    //Action to login directly from facebook
    @IBAction func facebookLoginTapped(_ sender: UIButton) {
       let facebookLogin = FBSDKLoginManager()
        facebookLogin.logIn(withReadPermissions: ["email"], from: self) { (result, error) in
            if error != nil {
                
                print("Rao:Unable to fetch user request data to Facebook-\(error)")
            }else if result?.isCancelled == true {
                print("Rao:User Cancelled facebook authentications")
            }
            else{
                print("Rao:Data grab sucessfully")
                let credentials = FacebookAuthProvider.credential(withAccessToken: FBSDKAccessToken.current().tokenString)
                self.firebaseAuth(credentials)
            
            }
        }
    }
    //Authenticate from User From firebase
    func firebaseAuth(_ credential : AuthCredential){
        Auth.auth().signIn(with: credential) { (user, error) in
            if error != nil{
                
                print("Rao:unable to login with facebook sdk -\(error)")
            }else{
                print("Rao:Login Succesfully")
                if let user = user{
                    let userdata = ["provide": credential.provider]
//                    self.completeSignin(id: user.uid)
                    self.completeSignin(id: user.uid, userdata: userdata)
                }
            }
            
        }
    }
    
    
    //Sign in btn to Firebase Email And Login
    
    @IBAction func SignIn(_ sender: AnyObject) {
        if let email = emailField.text , let pwd = pswdField.text{
           Auth.auth().signIn(withEmail: email, password: pwd, completion: { (user, error) in
            if error == nil{
                
                print("Rao : Email User Authenticated with firebase")
                if let user = user{
                    let userdata = ["provider" : user.providerID]
                        self.completeSignin(id: user.uid, userdata: userdata)
                }
                
            }else{
                Auth.auth().createUser(withEmail: email, password: pwd, completion: { (user, error) in
                    if error != nil {
                        print("Rao: Error create user in Firebase")
                        
                    }else{
                        print("Rao: User Succesfully Created in FireBase")
                        if let user = user{
                            let userdata = ["provider" : user.providerID]
//                            self.completeSignin(id: user.uid)
                            self.completeSignin(id: user.uid, userdata: userdata)
                        }
                    }
                })
            }
           })
        }
    }
    
    //Complete Sign in to check Swifty wrapper either to save previous Login
    func completeSignin(id:String,userdata : Dictionary<String, String>){
    DatabseService.Db.createFirbaseDBUser(uid: id, userdata: userdata)
    let keychainresult = KeychainWrapper.standard.set(id, forKey: KEY_UID)
        print("Rao: key Chain Result and saved result" , keychainresult)
        performSegue(withIdentifier: "FeedVC", sender: nil)
    }
}











