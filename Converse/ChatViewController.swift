//
//  ChatViewController.swift
//  Converse
//
//  Created by Kareem Ismail on 8/16/17.
//  Copyright © 2017 Whatever. All rights reserved.
//

import UIKit

class ChatViewController: UIViewController {
    
    @IBOutlet weak var burgerButton: UIButton!
    @IBOutlet weak var pleaseLoginLabel: UILabel!
    @IBOutlet weak var converseLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        burgerButton.addTarget(self.revealViewController(), action: #selector(SWRevealViewController.revealToggle(_:)), for: .touchUpInside)
        self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        self.view.addGestureRecognizer(self.revealViewController().tapGestureRecognizer())
        NotificationCenter.default.addObserver(self, selector: #selector(ChatViewController.reverseLoginLabelState), name: NOTIFY_USER_DATA_CHANGE, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(ChatViewController.channelSelected), name: NOTIFY_CHANNEL_SELECTED, object: nil)
        if AuthService.instance.isLoggedIn {
            AuthService.instance.findUserByMail(completion: { (success) in
                if success {
                    NotificationCenter.default.post(name: NOTIFY_USER_DATA_CHANGE, object: nil)
                }
                MessagesService.instance.getAllChannels(completion: { (success) in
                
                })
            })
        }
    }
    
    @objc func reverseLoginLabelState(){
        if pleaseLoginLabel.isHidden {
            pleaseLoginLabel.isHidden = false
        }
        else {
            pleaseLoginLabel.isHidden = true
        }
    }
    
    @objc func channelSelected(){
        updateWithChannel()
    }
    
    func updateWithChannel(){
        let channelName = MessagesService.instance.selectedChannel?.name ?? ""
        converseLabel.text = "#\(channelName)"
    }
    
    
    
    
}
