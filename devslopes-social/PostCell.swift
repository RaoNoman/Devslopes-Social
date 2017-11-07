//
//  PostCell.swift
//  devslopes-social
//
//  Created by Rao Noman on 11/1/17.
//  Copyright © 2017 Rao Noman. All rights reserved.
//

import UIKit
import Firebase

class PostCell: UITableViewCell {

    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var username : UILabel!
    @IBOutlet weak var postImg : UIImageView!
    @IBOutlet weak var caption : UITextView!
    @IBOutlet weak var likesLbl : UILabel!
    
    var post : Post!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func configureUI(post : Post , img : UIImage? = nil){
        self.post = post
        self.likesLbl.text = "\(post.likes)"
        self.caption.text = "\(post.caption)"
        self.username.text = "Rao M. Noman"
        
        if img != nil{
            self.postImg.image = img
        }else{
            let ref = Storage.storage().reference(forURL: post.imageURL)
            ref.getData(maxSize: 2*1024*1024, completion: { (data, error) in
                if error !=  nil{
                    print("Unable to get image from firebse")
                }else{
                    print("get image from firebase")
                    if let imagedata = data{
                        if let img = UIImage(data: imagedata){
                            self.postImg.image = img
                            FeedVC.ImageCache.setObject(img, forKey: post.imageURL as NSString)
                        }
                    }
                }
            })
        }
    }
}
