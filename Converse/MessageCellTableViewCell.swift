//
//  MessageCellTableViewCell.swift
//  Converse
//
//  Created by Kareem Ismail on 8/31/17.
//  Copyright © 2017 Whatever. All rights reserved.
//

import UIKit

class MessageCell: UITableViewCell {

    @IBOutlet weak var messageLabel: UILabel!
    @IBOutlet weak var dateAndTimeLabel: UILabel!
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var profileImage: CircleImage!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func configureCell(message: Message){
        messageLabel.text = message.body
        usernameLabel.text = message.userName
        profileImage.image = UIImage(named: message.userAvatar)
        profileImage.backgroundColor = UserDataService.instance.returnUIColor(components: message.userAvatarColor)
    }

}
