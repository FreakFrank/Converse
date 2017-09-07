//
//  ProfileViewController.swift
//  Converse
//
//  Created by Kareem Ismail on 8/25/17.
//  Copyright © 2017 Whatever. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController {
   
    @IBOutlet weak var bgView: UIView!
    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var userNameLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpUserData()
        setupTapRecognizer()
        NotificationCenter.default.addObserver(self, selector: #selector(ProfileViewController.usernameDidChange), name: NOTIFY_USER_DATA_CHANGE, object: nil)
    }
    @IBAction func closeButtonPressed(_ sender: Any) {
        
        dismiss(animated: true, completion: nil)
        
    }
    @IBAction func logoutButtonPressed(_ sender: Any) {
        UserDataService.instance.logoutUser()
        NotificationCenter.default.post(name: NOTIFY_USER_DATA_CHANGE, object: nil)
        dismiss(animated: true, completion: nil)
    }
    
    @objc func usernameDidChange(){
        setUpUserData()
    }
    
    @IBAction func editUsernamePressed(_ sender: Any) {
        
        let editUsername = EditUsernameViewController()
        editUsername.modalPresentationStyle = .custom
        present(editUsername, animated: true, completion: nil)
        
    }
    func setUpUserData(){
        if AuthService.instance.isLoggedIn {
            self.profileImage.image = UIImage(named: UserDataService.instance.avatarName)
            self.profileImage.backgroundColor = UserDataService.instance.returnUIColor(components: UserDataService.instance.avatarColor)
            self.emailLabel.text = UserDataService.instance.email
            self.userNameLabel.text = UserDataService.instance.name
        }
        else {
            profileImage.image = UIImage(named:"menuProfileIcon")
            profileImage.backgroundColor = UIColor.clear
        }
        
    }
    
    func setupTapRecognizer(){
        let tap = UITapGestureRecognizer(target: self, action: #selector(ProfileViewController.handleTap))
        bgView.addGestureRecognizer(tap)
    }
    
    @objc func handleTap(){
        dismiss(animated: true, completion: nil)
    }

}
