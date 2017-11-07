//
//  Post.swift
//  devslopes-social
//
//  Created by Rao Noman on 11/6/17.
//  Copyright © 2017 Rao Noman. All rights reserved.
//

import Foundation


class Post{
    private var _caption : String!
    private var _imageURL : String!
    private var _likes : Int!
    private var _postKey :String!
    
    
    var caption : String{
        return _caption
    }
    var imageURL : String{
        return _imageURL
    }
    var likes : Int{
        return _likes
    }
    
    init(caption:String , imageURL:String , like:Int) {
        self._caption = caption
        self._imageURL = imageURL
        self._likes = like
        
    }
    init(postKey : String , postdata: Dictionary<String , AnyObject>) {
        self._postKey = postKey
        if let image = postdata["ImageUrl"] as? String{
            self._imageURL = image
        }
        if let like = postdata["Likes"] as? Int{
            self._likes = like
        }
        if let caption = postdata["Caption"] as? String{
            self._caption = caption
        }
        
    }
    
}
