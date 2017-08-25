//
//  LoginViewController.swift
//  Converse
//
//  Created by Kareem Ismail on 8/18/17.
//  Copyright © 2017 Whatever. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {
    @IBOutlet weak var loginSpinner: UIActivityIndicatorView!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var usernameTextField: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    

    @IBAction func closeButtonPressed(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    @IBAction func signUpButtonPressed(_ sender: Any) {
        performSegue(withIdentifier: TO_CREATE_ACCOUNT, sender:nil)
    }

    
    @IBAction func loginButtonPressed(_ sender: Any) {
        
        loginSpinner.isHidden = false
        loginSpinner.startAnimating()
        
        guard let email = usernameTextField.text, usernameTextField.text != "" else {return}
        guard let password = passwordTextField.text, passwordTextField.text != "" else {return}
        
        AuthService.instance.loginUser(email: email, password: password) { (success) in
            if success {
                AuthService.instance.findUserByMail(completion: { (success) in
                    
                    NotificationCenter.default.post(name: NOTIFY_USER_DATA_CHANGE, object: nil)
                    self.loginSpinner.isHidden = true
                    self.loginSpinner.stopAnimating()
                    self.dismiss(animated: true, completion: nil)
                })
            }
        }
        
        
    }
    
    func setupView(){
        
        usernameTextField.attributedPlaceholder = NSAttributedString(string: "email", attributes: [NSForegroundColorAttributeName: purpleColor])
        passwordTextField.attributedPlaceholder = NSAttributedString(string: "password", attributes: [NSForegroundColorAttributeName: purpleColor])
        loginSpinner.isHidden = true
        
    }
}
