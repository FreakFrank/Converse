//
//  AuthService.swift
//  Converse
//
//  Created by Kareem Ismail on 8/22/17.
//  Copyright © 2017 Whatever. All rights reserved.
//

import Foundation
import Alamofire

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
        let header = [
            "Content-Type" : "application/json; charset=utf-8"
        ]
        let body = [
            "email" : loweredCasedEmail,
            "password": password
        ]
        
        Alamofire.request(REGISTER_URL, method: .post, parameters: body, encoding: JSONEncoding.default, headers: header).responseString {
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

}
