//
//  LoginViewController.swift
//  Converse
//
//  Created by Kareem Ismail on 8/18/17.
//  Copyright © 2017 Whatever. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {

    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var usernameTextField: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        setPlaceHolderTextColor()
        // Do any additional setup after loading the view.
    }
    

    @IBAction func closeButtonPressed(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    @IBAction func signUpButtonPressed(_ sender: Any) {
        performSegue(withIdentifier: TO_CREATE_ACCOUNT, sender:nil)
    }
    
    func setPlaceHolderTextColor(){
        usernameTextField.attributedPlaceholder = NSAttributedString(string: "username", attributes: [NSForegroundColorAttributeName: purpleColor])
        passwordTextField.attributedPlaceholder = NSAttributedString(string: "password", attributes: [NSForegroundColorAttributeName: purpleColor])
    }
    
}
