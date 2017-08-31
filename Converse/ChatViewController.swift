//
//  ChatViewController.swift
//  Converse
//
//  Created by Kareem Ismail on 8/16/17.
//  Copyright © 2017 Whatever. All rights reserved.
//

import UIKit

class ChatViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var burgerButton: UIButton!
    @IBOutlet weak var converseLabel: UILabel!
    @IBOutlet weak var messageTextField: UITextField!
    @IBOutlet weak var messagesTabelView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        messagesTabelView.delegate = self
        messagesTabelView.dataSource = self
        messagesTabelView.estimatedRowHeight = 80
        messagesTabelView.rowHeight = UITableViewAutomaticDimension
        view.bindToKeyboard()
        setupView()
        burgerButton.addTarget(self.revealViewController(), action: #selector(SWRevealViewController.revealToggle(_:)), for: .touchUpInside)
        self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        self.view.addGestureRecognizer(self.revealViewController().tapGestureRecognizer())
        NotificationCenter.default.addObserver(self, selector: #selector(ChatViewController.userDataDidChange), name: NOTIFY_USER_DATA_CHANGE, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(ChatViewController.channelSelected), name: NOTIFY_CHANNEL_SELECTED, object: nil)
        SocketService.instance.getMessage { (success) in
            if success {
                self.messagesTabelView.reloadData()
                if MessagesService.instance.messages.count > 0 {
                    let endIndex = IndexPath(row: MessagesService.instance.messages.count - 1, section: 0)
                    self.messagesTabelView.scrollToRow(at: endIndex, at: .bottom, animated: false)
                }
            }
        }
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
    
    @objc func userDataDidChange(){
        if AuthService.instance.isLoggedIn {
            onLoginGetMessages()
        }
        else {
            converseLabel.text = "Please Login"
        }
        messagesTabelView.reloadData()
    }
    
    @objc func channelSelected(){
        updateWithChannel()
    }
    
    func updateWithChannel(){
        let channelName = MessagesService.instance.selectedChannel?.name ?? ""
        converseLabel.text = "#\(channelName)"
        getMessages()
    }
    
    func onLoginGetMessages(){
        MessagesService.instance.getAllChannels { (success) in
            if success {
                if MessagesService.instance.channels.count > 0 {
                    MessagesService.instance.selectedChannel = MessagesService.instance.channels[0]
                    self.updateWithChannel()
                }
                else {
                    self.converseLabel.text = "No channels yet"
                }
            }
        }
    }
    
    func getMessages(){
        guard let channelId = MessagesService.instance.selectedChannel?.id else {return}
        MessagesService.instance.getAllMessagesForSpecificChannel(channelId: channelId) { (success) in
            if success {
                self.messagesTabelView.reloadData()
            }
        }
    }
    @IBAction func sendButtonPressed(_ sender: Any) {
        
        guard let message = messageTextField.text else {return}
        guard let channelId = MessagesService.instance.selectedChannel?.id else {return}
        
        SocketService.instance.addMessage(messageBody: message, userId: UserDataService.instance.id, channelId: channelId) { (success) in
            if success {
                self.messageTextField.text = ""
                self.messageTextField.resignFirstResponder()
            }
        }
        
    }
    
    func setupView(){
        let tap = UITapGestureRecognizer(target: self, action: #selector(ChatViewController.endEditing))
        view.addGestureRecognizer(tap)
        
    }
    
    @objc func endEditing(){
        view.endEditing(true)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "messageCell", for: indexPath) as? MessageCell {
            let message = MessagesService.instance.messages[indexPath.row]
            cell.configureCell(message: message)
            return cell
        }
        return UITableViewCell()
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if AuthService.instance.isLoggedIn {
            return MessagesService.instance.messages.count
        }
        else {
            return 0
        }
        
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
}
