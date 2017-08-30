//
//  MessagesService.swift
//  Converse
//
//  Created by Kareem Ismail on 8/26/17.
//  Copyright © 2017 Whatever. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

class MessagesService {
    
    static let instance = MessagesService()
    
    var channels = [Channel]()
    var messages = [Message]()
    var selectedChannel: Channel?
    
    func getAllChannels(completion: @escaping CompletionHandler){
        print("getting all channels")
        Alamofire.request(GET_CHANNELS_URL, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: BEARER_HEADER).responseJSON { (response) in
            
            if response.result.error == nil {
                self.clearAllChannels()
                guard let data = response.data else {return}
                if let json = JSON(data: data).array{
                    for item in json {
                        let name = item["name"].stringValue
                        let description = item["description"].stringValue
                        let id = item["_id"].stringValue
                        let channel = Channel(name: name, description: description, id: id)
                        self.channels.append(channel)
                    }
                    NotificationCenter.default.post(name: NOTIFY_CHANNELS_LOADED, object: nil)
                    completion(true)
                    print("The count of channels is \(self.channels.count)")
                    
                }
                
            }
            else {
                completion(false)
                debugPrint(response.result.error as Any)
            }
        }
    }
    
    func getAllMessagesForSpecificChannel(channelId: String, completion: @escaping CompletionHandler){
        print("channel id is \(channelId)")
        Alamofire.request("\(GET_MESSAGES_URL)\(channelId)", method: .get, parameters: nil, encoding: JSONEncoding.default, headers: BEARER_HEADER).responseJSON { (response) in
            
            if response.result.error == nil {
                self.clearAllMessages()
                guard let data = response.data else {return}
                
                if let json = JSON(data: data).array{
                    for item in json {
                        let body = item["messageBody"].stringValue
                        let channelId = item["channelId"].stringValue
                        let userId = item["userId"].stringValue
                        let id = item["_id"].stringValue
                        let userAvatar = item["userAvatar"].stringValue
                        let userAvatarColor = item["userAvatarColor"].stringValue
                        let timeStamp = item["timeStamp"].stringValue
                        let userName = item["userName"].stringValue
                        let message = Message(id: id, body: body, userId: userId, channelId: channelId, userName: userName, userAvatar: userAvatar, userAvatarColor: userAvatarColor, timeStamp: timeStamp)
                        self.messages.append(message)
                    }
                    completion(true)
                }
                
            }
            else{
                debugPrint(response.result.error as Any)
                completion(false)
            }
            
        }
        
    }
    
    func clearAllMessages(){
        messages.removeAll()
    }
    
    func clearAllChannels(){
        channels.removeAll()
    }
}
