//
//  CircleImage.swift
//  devslopes-social
//
//  Created by Rao Noman on 10/31/17.
//  Copyright © 2017 Rao Noman. All rights reserved.
//

import UIKit

class CircleImage: UIImageView {

    override func layoutSubviews() {
        layer.shadowColor = UIColor(red: SHADOW_COLOR, green: SHADOW_COLOR, blue: SHADOW_COLOR, alpha: 0.6).cgColor
        
        layer.shadowOpacity = 0.8
        layer.shadowRadius = 5.0
        layer.shadowOffset = CGSize(width: 1.0, height: 1.0)
            }

}
