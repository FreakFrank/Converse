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
    
    func getAllChannels(completion: @escaping CompletionHandler){
        Alamofire.request(GET_CHANNELS_URL, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: BEARER_HEADER).responseJSON { (response) in
            
            if response.result.error == nil {
                
                guard let data = response.data else {return}
                if let json = JSON(data: data).array{
                    print("the count of channels is \(json.count)")
                    for item in json {
                        let name = item["name"].stringValue
                        let description = item["description"].stringValue
                        let id = item["id"].stringValue
                        let channel = Channel(name: name, description: description, id: id)
                        self.channels.append(channel)
                    }
                completion(true)
                    
                }
                
            }
            else {
                completion(false)
                debugPrint(response.result.error as Any)
            }
            
        }
    }
    
    func clearAllChannels(){
        channels.removeAll()
    }
}
