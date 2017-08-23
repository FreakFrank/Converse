//
//  AvatarCellCollectionViewCell.swift
//  Converse
//
//  Created by Kareem Ismail on 8/23/17.
//  Copyright © 2017 Whatever. All rights reserved.
//

import UIKit

enum AvatarType{
    case light
    case dark
}

class AvatarCellCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var avatarImage: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setUpView()
    }
    
    func configureCell(index: Int, type: AvatarType){
        avatarImage.image = UIImage(named: "\(type)\(index)")
        if(type == AvatarType.dark) {
            self.layer.backgroundColor = UIColor.lightGray.cgColor
        }
        else {
            self.layer.backgroundColor = UIColor.gray.cgColor
        }
    }
    
    func setUpView(){
        self.layer.backgroundColor = UIColor.lightGray.cgColor
        self.layer.cornerRadius = 10
        self.clipsToBounds = true
    }
    
}
