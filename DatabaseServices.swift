//
//  DatabaseServices.swift
//  devslopes-social
//
//  Created by Rao Noman on 11/2/17.
//  Copyright © 2017 Rao Noman. All rights reserved.
//

import Foundation
import Firebase



let DB_Base = Database.database().reference()
let STORAGE_BASE = Storage.storage().reference()

class DatabseService {
    
    static let Db = DatabseService()
    //database Services
    private var _REF_BASE = DB_Base
    private var _REF_POST = DB_Base.child("Posts")
    private var _REF_USER = DB_Base.child("Users")
    
    //Storgae Sevice
    private var _REF_POST_IMAGES = STORAGE_BASE.child("post-pics")
    
    
    var REF_BASE : DatabaseReference{
      return _REF_BASE
    }
    var REF_POST : DatabaseReference{
     return _REF_POST
    }
    var REF_USER : DatabaseReference{
        return _REF_USER
    }
    var REF_POST_IMAGES : StorageReference{
        return _REF_POST_IMAGES
    }
    
    func createFirbaseDBUser(uid:String , userdata: Dictionary<String ,String>){
        REF_USER.child(uid).updateChildValues(userdata)
    }
    
}
