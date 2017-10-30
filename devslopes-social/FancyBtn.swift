//
//  FancyBtn.swift
//  devslopes-social
//
//  Created by Rao Noman on 10/30/17.
//  Copyright © 2017 Rao Noman. All rights reserved.
//

import UIKit

class FancyBtn: UIButton {

    override func awakeFromNib() {
        super.awakeFromNib()
        
        layer.shadowColor = UIColor(red: SHADOW_COLOR, green: SHADOW_COLOR, blue: SHADOW_COLOR, alpha: 0.6).cgColor
        layer.shadowRadius = 5.0
        layer.shadowOpacity = 8.0
        layer.shadowOffset = CGSize(width: 1.0, height: 1.0)
    
    }
    override func layoutSubviews() {
        super.layoutSubviews()
        
        layer.cornerRadius = 2
    }

}
