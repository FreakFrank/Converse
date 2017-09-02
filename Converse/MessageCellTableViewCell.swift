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
        guard var isoDate = message.timeStamp else {return}
        let end = isoDate.index(isoDate.endIndex, offsetBy: -5)
        isoDate = isoDate.substring(to: end)
        
        let isoFormatter = ISO8601DateFormatter()
        let chatDate = isoFormatter.date(from: isoDate.appending("Z"))
        
        let newFormatter = DateFormatter()
        newFormatter.dateFormat = "MMM d, h:mm a"
        if let finalDate = chatDate {
            let finalDate = newFormatter.string(from: finalDate)
            dateAndTimeLabel.text = finalDate
        }
    }

}
