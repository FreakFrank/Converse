//
//  AuthService.swift
//  Converse
//
//  Created by Kareem Ismail on 8/22/17.
//  Copyright © 2017 Whatever. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

class AuthService {

    static let instance = AuthService()
    
    let defaults = UserDefaults.standard
    
    var isLoggedIn : Bool {
        get {
            return defaults.bool(forKey: LOGGED_IN_KEY)
        }
        set {
            defaults.set(newValue, forKey: LOGGED_IN_KEY)
        }
    }
    
    var authToken : String {
        get {
            return defaults.value(forKey: TOKEN_KEY) as! String
        }
        set {
            defaults.set(newValue, forKey: TOKEN_KEY)
        }
    }
    
    var userEmail : String {
        get {
            return defaults.value(forKey: USER_EMAIL) as! String
        }
        set {
            defaults.set(newValue, forKey: USER_EMAIL)
        }
    }
    
    func registerUser(email: String, password: String, completion: @escaping CompletionHandler) {
        let loweredCasedEmail = email.lowercased()
        let body = [
            "email" : loweredCasedEmail,
            "password": password
        ]
        
        Alamofire.request(REGISTER_URL, method: .post, parameters: body, encoding: JSONEncoding.default, headers: HEADER).responseString {
            (response) in
                if response.error == nil {
                    completion(true)
                }
                else {
                    completion(false)
                    debugPrint(response.result.error as Any)
                }
            
        }
    }
    
    func loginUser(email: String, password: String, completion: @escaping CompletionHandler) {
        let loweredCasedEmail = email.lowercased()
        let body = [
            "email" : loweredCasedEmail,
            "password": password
        ]
    
        Alamofire.request(LOGIN_URL, method: .post, parameters: body, encoding: JSONEncoding.default, headers: HEADER).responseJSON{
            (response) in
                if response.result.error == nil {
//                    if let json = response.result.value as? Dictionary<String, Any> {
//                        if let email = json["user"] as? String {
//                            self.userEmail = email
//                        }
//                        if let token = json["token"] as? String {
//                            self.authToken = token
//                        }
//                    }
                    guard let data = response.data else {return}
                    let json = JSON(data: data)
                    self.userEmail = json["user"].stringValue
                    self.authToken = json["token"].stringValue
                    self.isLoggedIn = true
                    completion(true)
            }
                else {
                    completion(false)
                    debugPrint(response.result.error as Any)
            }
        }
    }
    
    func createUser(name: String, email:String, avatarName: String, avatarColor: String, completion: @escaping CompletionHandler) {
        let lowerCasedEmail = email.lowercased()
        let body: [String:Any] = [
            "name": name,
            "email": lowerCasedEmail,
            "avatarName": avatarName,
            "avatarColor": avatarColor
        ]
        
        
        Alamofire.request(CREATE_USER_URL, method: .post, parameters: body, encoding: JSONEncoding.default, headers: BEARER_HEADER).responseJSON {
            (response) in
            if response.result.error == nil {
                guard let data = response.data else {return}
                self.setUserData(data: data)
                completion(true)
            }
            else {
                completion(false)
                debugPrint(response.result.error as Any)
            }
        }
    }
    
    func findUserByMail(completion: @escaping CompletionHandler){
        print(userEmail)
        Alamofire.request("\(GET_USER_BY_MAIL_URL)\(userEmail)", method: .get, parameters: nil, encoding: JSONEncoding.default, headers: BEARER_HEADER).responseJSON { (response) in
            if response.result.error == nil {
                guard let data = response.data else {return}
                self.setUserData(data: data)
                completion(true)
            }
            else {
                completion(false)
                debugPrint(response.result.error as Any)
            }
        }
    }
    
    func setUserData(data: Data){
        let json = JSON(data: data)
        let id = json["_id"].stringValue
        let avatarColor = json["avatarColor"].stringValue
        let avatarName = json["avatarName"].stringValue
        let email = json["email"].stringValue
        let name = json["name"].stringValue
        UserDataService.instance.setUserData(id: id, avatarColor: avatarColor, avatarName: avatarName, email: email, name: name)
    }
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    

}
