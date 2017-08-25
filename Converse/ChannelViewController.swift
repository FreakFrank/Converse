//
//  ChannelViewController.swift
//  Converse
//
//  Created by Kareem Ismail on 8/16/17.
//  Copyright © 2017 Whatever. All rights reserved.
//

import UIKit

class ChannelViewController: UIViewController {

    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var loginButton: UIButton!
    @IBAction func prepareForUnwind(segue: UIStoryboardSegue){}
    override func viewDidLoad() {
        super.viewDidLoad()
        self.revealViewController().rearViewRevealWidth = self.view.frame.size.width - 60
        NotificationCenter.default.addObserver(self, selector: #selector(userDataChanged), name: NOTIFY_USER_DATA_CHANGE, object: nil)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        setupUserData()
    }


    @IBAction func loginButtonPressed(_ sender: Any) {
        
        if AuthService.instance.isLoggedIn {
            let profile = ProfileViewController()
            profile.modalPresentationStyle = .custom
            present(profile, animated: true, completion: nil)
        }
            
        else {
            performSegue(withIdentifier: TO_LOGIN , sender:nil)
        }
        
    }
    
   @objc func userDataChanged(){
        setupUserData()
    }
    
    func setupUserData(){
        if AuthService.instance.isLoggedIn {
            loginButton.setTitle(UserDataService.instance.name, for: .normal)
            profileImage.image = UIImage(named: UserDataService.instance.avatarName)
            profileImage.backgroundColor = UserDataService.instance.returnUIColor(components: UserDataService.instance.avatarColor)
        }
        else {
            loginButton.setTitle("Login", for: .normal)
            profileImage.image = UIImage(named:"menuProfileIcon")
            profileImage.backgroundColor = UIColor.clear
        }
    }
}
