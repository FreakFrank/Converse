//
//  CreateAccountViewController.swift
//  Converse
//
//  Created by Kareem Ismail on 8/20/17.
//  Copyright © 2017 Whatever. All rights reserved.
//

import UIKit

class CreateAccountViewController: UIViewController {
    
    @IBOutlet weak var createAccButton: RoundedButton!
    @IBOutlet weak var loadingSpinner: UIActivityIndicatorView!
    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var usernameTextField: UITextField!
    var avatarName = "profileDefault"
    var avatarColor = "[0.5, 0.5, 0.5, 1]"
    var bgColor : UIColor?
    override func viewDidLoad() {
        super.viewDidLoad()
        setPlaceHolderTextColor()
        setUpTapRecognizer()
    }

    @IBAction func cancelButtonPressed(_ sender: Any) {
        performSegue(withIdentifier: UNWIND_TO_CHANNEL, sender: nil)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        if UserDataService.instance.avatarName != "" {
            profileImage.image = UIImage(named: "\(UserDataService.instance.avatarName)")
            avatarName = UserDataService.instance.avatarName
            if avatarName.contains("light") && bgColor == nil {
                profileImage.backgroundColor = UIColor.lightGray
            }
        }
    }

    @IBAction func createAccBtnPressed(_ sender: Any) {
        createAccButton.isEnabled = false
        loadingSpinner.isHidden = false
        loadingSpinner.startAnimating()
        guard let name = usernameTextField.text, usernameTextField.text != "" else {return}
        guard let email = emailTextField.text, emailTextField.text != "" else {return}
        guard let password = passwordTextField.text, passwordTextField.text != "" else {return}
        
        AuthService.instance.registerUser(email: email, password: password){
            (success) in
            if success {
                AuthService.instance.loginUser(email: email, password: password, completion: {(success) in
                    if success {
                        AuthService.instance.createUser(name: name, email: email, avatarName: self.avatarName, avatarColor: self.avatarColor, completion: { (success) in
                            if success {
                                print(UserDataService.instance.avatarName, UserDataService.instance.email)
                                self.loadingSpinner.stopAnimating()
                                self.performSegue(withIdentifier: UNWIND_TO_CHANNEL, sender: nil)
                                NotificationCenter.default.post(name: NOTIFY_USER_DATA_CHANGE, object: nil)
                            }
                        })
                    }
                })
            }
        }
        
    }
    @IBAction func chooseAvatarPressed(_ sender: Any) {
        
        performSegue(withIdentifier: TO_AVATAR_PICKER, sender: nil)
        
    }
    @IBAction func generateBckGrndPressed(_ sender: Any) {
    
        let r = CGFloat(arc4random_uniform(255)) / 255
        let g = CGFloat(arc4random_uniform(255)) / 255
        let b = CGFloat(arc4random_uniform(255)) / 255
        avatarColor = "[\(r), \(g), \(b), 1]"
        self.bgColor = UIColor(red: r, green: g, blue: b, alpha: 1)
        UIView.animate(withDuration: 0.3){
            self.profileImage.backgroundColor = self.bgColor
        }
        
    }
    
    func setPlaceHolderTextColor(){
        loadingSpinner.isHidden = true
        usernameTextField.attributedPlaceholder = NSAttributedString(string: "username", attributes: [NSForegroundColorAttributeName: purpleColor])
        passwordTextField.attributedPlaceholder = NSAttributedString(string: "password", attributes: [NSForegroundColorAttributeName: purpleColor])
        emailTextField.attributedPlaceholder = NSAttributedString(string: "email", attributes: [NSForegroundColorAttributeName: purpleColor])

    }
    
    func setUpTapRecognizer(){
        let tap = UITapGestureRecognizer(target: self, action: #selector(CreateAccountViewController.handleTap))
        view.addGestureRecognizer(tap)
    }
    
    @objc func handleTap(){
        view.endEditing(true)
    }
    
    
    
    
    
    
    
    
    
    
    
    
    
    
}
