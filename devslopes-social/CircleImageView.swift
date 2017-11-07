//
//  CircleImageView.swift
//  devslopes-social
//
//  Created by Rao Noman on 11/7/17.
//  Copyright © 2017 Rao Noman. All rights reserved.
//

import UIKit

class CircleImageView: UIImageView {

    override func layoutSubviews() {
       layer.cornerRadius = self.frame.width / 2
        clipsToBounds = true
    }

}
