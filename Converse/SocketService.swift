//
//  SocketService.swift
//  Converse
//
//  Created by Kareem Ismail on 8/27/17.
//  Copyright © 2017 Whatever. All rights reserved.
//

import UIKit
import SocketIO

class SocketService: NSObject {
    static var instance = SocketService()
    
    override init() {
        super.init()
    }
    
    var socket: SocketIOClient = SocketIOClient(socketURL: URL(string: BASE_URL)!)
    
    func establishConnection(){
        socket.connect()
    }
    
    func terminateConnection(){
        socket.disconnect()
    }
    
    func addChannel(channelName: String, channelDescription: String, completion: @escaping CompletionHandler){
        socket.emit("newChannel", channelName, channelDescription)
        completion(true)
    }
    
    func updateChannels(completion: @escaping CompletionHandler){
        print("got into the update channels")
        socket.on("channelCreated") { (dataArray, ack) in
            guard let channelName = dataArray[0] as? String else {return}
            guard let channelDescription = dataArray[1] as? String else {return}
            guard let channelId = dataArray[2] as? String else {return}
            let newChannel = Channel(name: channelName, description: channelDescription, id: channelId)
            MessagesService.instance.channels.append(newChannel)
            completion(true)
        }
    }
    
    func addMessage(messageBody: String, userId: String, channelId: String, completion: @escaping CompletionHandler){
        
        let user = UserDataService.instance
        socket.emit("newMessage", messageBody, userId, channelId, user.name, user.avatarName, user.avatarColor)
        completion(true)
        
    }
    
    func getMessage(completion: @escaping CompletionHandler){
        
        socket.on("messageCreated") { (dataArray, ack) in
            guard let message = dataArray[0] as? String else {return}
            guard let channelId = dataArray[2] as? String else {return}
            guard let userName = dataArray[3] as? String else {return}
            guard let userAvatar = dataArray[4] as? String else {return}
            guard let userAvatarColor = dataArray[5] as? String else {return}
            guard let id = dataArray[6] as? String else {return}
            guard let timeStamp = dataArray[7] as? String else {return}
            
            if channelId == MessagesService.instance.selectedChannel?.id && AuthService.instance.isLoggedIn {
                let newMessage = Message(id: id, body: message, userId: "", channelId: channelId, userName: userName, userAvatar: userAvatar, userAvatarColor: userAvatarColor, timeStamp: timeStamp)
                MessagesService.instance.messages.append(newMessage)
                completion(true)
            }
            else {
                completion(false)
            }
        }
    
    }
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
}
