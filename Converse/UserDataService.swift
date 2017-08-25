//
//  UserDataService.swift
//  Converse
//
//  Created by Kareem Ismail on 8/22/17.
//  Copyright © 2017 Whatever. All rights reserved.
//

import Foundation

class UserDataService{
    static let instance = UserDataService()
    
    public private(set) var id = ""
    public private(set) var avatarColor = ""
    public private(set) var avatarName = ""
    public private(set) var email = ""
    public private(set) var name = ""
    
    func setUserData(id: String, avatarColor: String, avatarName: String, email: String, name: String){
        self.id = id
        self.avatarColor = avatarColor
        self.avatarName = avatarName
        self.email = email
        self.name = name
    }
    
    func setAvatarName(avatarName: String){
        self.avatarName = avatarName
    }
    
    func returnUIColor(components: String) -> UIColor {
        
        let colorsScanner = Scanner(string: components)
        let charsToSkip = CharacterSet(charactersIn: "[], ")
        let comma = CharacterSet(charactersIn: ",")
        colorsScanner.charactersToBeSkipped = charsToSkip
        var r, g, b, a : NSString?
        
        colorsScanner.scanUpToCharacters(from: comma, into: &r)
        colorsScanner.scanUpToCharacters(from: comma, into: &g)
        colorsScanner.scanUpToCharacters(from: comma, into: &b)
        colorsScanner.scanUpToCharacters(from: comma, into: &a)
        
        let defaultColor = UIColor.lightGray
        
        guard let rUnwrapped = r else { return defaultColor }
        guard let gUnwrapped = g else { return defaultColor }
        guard let bUnwrapped = b else { return defaultColor }
        guard let aUnwrapped = a else { return defaultColor }
        
        let rFloat = CGFloat(rUnwrapped.doubleValue)
        let gFloat = CGFloat(gUnwrapped.doubleValue)
        let bFloat = CGFloat(bUnwrapped.doubleValue)
        let aFloat = CGFloat(aUnwrapped.doubleValue)
        
        return UIColor(red: rFloat, green: gFloat, blue: bFloat, alpha: aFloat)


    }
    
    func logoutUser(){
        id = ""
        avatarColor = ""
        avatarName = ""
        email = ""
        name = ""
        AuthService.instance.isLoggedIn = false
        AuthService.instance.userEmail = ""
        AuthService.instance.authToken = ""
    }

}
