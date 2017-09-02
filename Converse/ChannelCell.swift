//
//  ChannelCell.swift
//  Converse
//
//  Created by Kareem Ismail on 8/26/17.
//  Copyright © 2017 Whatever. All rights reserved.
//

import UIKit

class ChannelCell: UITableViewCell {

    @IBOutlet weak var channelName: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        if selected {
            self.layer.backgroundColor = UIColor(white: 1, alpha: 0.2).cgColor
        }
        else {
            self.layer.backgroundColor = UIColor.clear.cgColor
        }
        
        
    }
    
    func configureCell(channel: Channel) {
        let channelTitle = channel.name ?? ""
        channelName.text = "#\(channelTitle)"
        let regularFont = UIFont(name: "AppleSDGothicNeo-Regular", size: 17)
        let bigFont = UIFont(name: "AppleSDGothicNeo-Bold", size: 20)
        if MessagesService.instance.unreadChannels.contains(channel.id) {
            channelName.font = bigFont
        }
        else {
            channelName.font = regularFont
        }

    }

}
