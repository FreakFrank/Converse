//
//  Constants.swift
//  Converse
//
//  Created by Kareem Ismail on 8/18/17.
//  Copyright © 2017 Whatever. All rights reserved.
//

import Foundation

typealias CompletionHandler = (_ Success: Bool) -> ()

//URLS

let BASE_URL = "https://conversea.herokuapp.com/v1/"
let REGISTER_URL = "\(BASE_URL)account/register"
let LOGIN_URL = "\(BASE_URL)account/login"
let CREATE_USER_URL = "\(BASE_URL)user/add"
let GET_USER_BY_MAIL_URL = "\(BASE_URL)user/byEmail/"
let GET_CHANNELS_URL = "\(BASE_URL)channel"
let GET_MESSAGES_URL = "\(BASE_URL)message/byChannel/"
let EDIT_USERNAME_URL = "\(BASE_URL)user/"


// Notifications

let NOTIFY_USER_DATA_CHANGE = Notification.Name("notifyUserDataChanged")
let NOTIFY_CHANNEL_SELECTED = Notification.Name("notifyChannelSelected")
let NOTIFY_CHANNELS_LOADED = Notification.Name("notifyChannelsLoaded")


// Colors

let purpleColor = #colorLiteral(red: 0.3254901961, green: 0.4215201139, blue: 0.7752227187, alpha: 0.5)

// Segues

let TO_LOGIN = "toLogin"
let TO_CREATE_ACCOUNT = "toCreateAccount"
let UNWIND_TO_CHANNEL = "toChannel"
let TO_AVATAR_PICKER = "toAvatarPicker"

// User defaults 

let TOKEN_KEY = "token"
let LOGGED_IN_KEY = "loggedIn"
let USER_EMAIL = "userEmail"


// Headers

let HEADER = [
    "Content-Type" : "application/json; charset=utf-8"
]

let BEARER_HEADER = [
    "Authorization": "Bearer \(AuthService.instance.authToken)",
    "Content-Type" : "application/json; charset=utf-8"
]



// Cells

let AVATAR_CELL_IDENTIFIER = "avatarCell"
let CHANNEL_CELL_IDENTFIER = "channelsCell"
