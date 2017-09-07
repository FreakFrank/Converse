//
//  EditUsernameViewController.swift
//  Converse
//
//  Created by Kareem Ismail on 9/7/17.
//  Copyright © 2017 Whatever. All rights reserved.
//

import UIKit

class EditUsernameViewController: UIViewController {

    @IBOutlet weak var originalView: UIView!
    @IBOutlet weak var bgView: UIView!
    @IBOutlet weak var editUsernameTextField: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()

    }

    @IBAction func confirmButtonPressed(_ sender: Any) {
        
        guard let newUsername = editUsernameTextField.text, editUsernameTextField.text != "" else {return}
        AuthService.instance.editUsername(newUsername: newUsername) { (success) in
            if success {
                NotificationCenter.default.post(name: NOTIFY_USER_DATA_CHANGE, object: nil)
                self.dismiss(animated: true, completion: nil)
            }
        }
        
        
    }
    
    @IBAction func closeButtonPressed(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    func setupView(){
        editUsernameTextField.text = UserDataService.instance.name
        let tap = UITapGestureRecognizer(target: self, action: #selector(EditUsernameViewController.dismissEditing))
        bgView.addGestureRecognizer(tap)
        let endEditingTap = UITapGestureRecognizer(target: self, action: #selector(EditUsernameViewController.endEditing))
        originalView.addGestureRecognizer(endEditingTap)
    }
    
    @objc func dismissEditing(){
        dismiss(animated: true, completion: nil)
    }
    
    @objc func endEditing(){
        view.endEditing(true)
    }
}
