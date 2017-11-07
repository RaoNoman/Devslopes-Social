//
//  FeedVC.swift
//  devslopes-social
//
//  Created by Rao Noman on 10/31/17.
//  Copyright © 2017 Rao Noman. All rights reserved.
//

import UIKit
import Firebase
import SwiftKeychainWrapper

class FeedVC: UIViewController,UIImagePickerControllerDelegate,UINavigationControllerDelegate{
    
    @IBOutlet weak var imageAdd: CircleImage!
    @IBOutlet weak var tableView: UITableView!
    var Posts = [Post]()
    var imagePicker : UIImagePickerController!

    //Cache for images download from firebase
    static var ImageCache : NSCache<NSString , UIImage> = NSCache()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
       //image picker  delegate
        imagePicker = UIImagePickerController()
        imagePicker.allowsEditing = true
        imagePicker.delegate = self
    
        DatabseService.Db.REF_POST.observe(.value , with: { (snapshot) in
            if let snapshot = snapshot.children.allObjects as? [DataSnapshot]{
                for snap in snapshot {
                    if let postdata = snap.value as? Dictionary<String, AnyObject>{
                        let key = snap.key
                        let post = Post(postKey: key, postdata: postdata)
                        self.Posts.append(post)
                        print("post \(post)")
                    }
                }
            }
            self.tableView.reloadData()
         })
    }
    
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        if let image = info[UIImagePickerControllerEditedImage] as? UIImage{
            imageAdd.image = image
        }
        else{
            print("RAo: Error in image edit")
        }
        imagePicker.dismiss(animated: true, completion: nil)
    }
    //Image picker tapped gesture add image
    @IBAction func addimageTapped(_ sender: UITapGestureRecognizer) {
        //print("RAo tapped tapped")
        present(imagePicker, animated: true, completion: nil)
        
    }
    //signout button
    @IBAction func signout(_ sender: AnyObject) {
        let keychainResult = KeychainWrapper.standard.removeObject(forKey: KEY_UID)
            try! Auth.auth().signOut()
        print("Key Chain Removed \(keychainResult)")
        performSegue(withIdentifier: "gotoSignIn", sender: nil)
    }

    
}


extension FeedVC : UITableViewDelegate , UITableViewDataSource{
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Posts.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as? PostCell
        {
            let Post = Posts[indexPath.row]
            if let img = FeedVC.ImageCache.object(forKey: Post.imageURL as NSString){
                cell.configureUI(post: Post, img: img)
                return cell
            }else{
                cell.configureUI(post: Post)
                return cell
            }
       
        }else{
        return UITableViewCell()
        }
    }
    
}

