//
//  CircleImage.swift
//  Converse
//
//  Created by Kareem Ismail on 8/23/17.
//  Copyright © 2017 Whatever. All rights reserved.
//

import UIKit

class CircleImage: UIImageView {
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setUpView()
    }
    
    func setUpView(){
        self.layer.cornerRadius = self.frame.size.width / 2
        self.clipsToBounds = true
    }
    
    override func prepareForInterfaceBuilder() {
        setUpView()
    }
    
   }
