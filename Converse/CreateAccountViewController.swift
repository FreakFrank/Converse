//
//  CreateAccountViewController.swift
//  Converse
//
//  Created by Kareem Ismail on 8/20/17.
//  Copyright © 2017 Whatever. All rights reserved.
//

import UIKit

class CreateAccountViewController: UIViewController {

    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var usernameTextField: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()

    }

    @IBAction func cancelButtonPressed(_ sender: Any) {
        performSegue(withIdentifier: UNWIND_TO_CHANNEL, sender: nil)
    }

    @IBAction func createAccBtnPressed(_ sender: Any) {
        
        guard let email = emailTextField.text, emailTextField.text != "" else {
            return
        }
        guard let password = passwordTextField.text, passwordTextField.text != "" else {
            return
        }
        
        AuthService.instance.registerUser(email: email, password: password){
            (success) in
            if success {
                print("Registerd user successfully")
            }
        }
        
    }
    @IBAction func chooseAvatarPressed(_ sender: Any) {
    }
    @IBAction func generateBckGrndPressed(_ sender: Any) {
    }
}
