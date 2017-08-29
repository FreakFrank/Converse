//
//  AddChannelViewController.swift
//  Converse
//
//  Created by Kareem Ismail on 8/26/17.
//  Copyright © 2017 Whatever. All rights reserved.
//

import UIKit

class AddChannelViewController: UIViewController {

    @IBOutlet weak var creationView: UIView!
    @IBOutlet weak var bgView: UIView!
    @IBOutlet weak var descriptionTextField: UITextField!
    @IBOutlet weak var nameTextField: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }

    @IBAction func closeButtonPressed(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }

    @IBAction func createButtonPressed(_ sender: Any) {
        guard let channelName = nameTextField.text, nameTextField.text != "" else {return}
        guard let channelDescription = descriptionTextField.text else {return}
        SocketService.instance.addChannel(channelName: channelName, channelDescription: channelDescription) { (success) in
            if success {
                self.dismiss(animated: true, completion: nil)
            }
        }
    }
    
    func setupView (){
        let closeTap = UITapGestureRecognizer(target: self, action: #selector(AddChannelViewController.closeTap))
        bgView.addGestureRecognizer(closeTap)
        let endEditingTap = UITapGestureRecognizer(target: self, action: #selector(AddChannelViewController.endEditing))
        creationView.addGestureRecognizer(endEditingTap)
        nameTextField.attributedPlaceholder = NSAttributedString(string: "name", attributes: [NSForegroundColorAttributeName: purpleColor])
        descriptionTextField.attributedPlaceholder = NSAttributedString(string: "description", attributes: [NSForegroundColorAttributeName: purpleColor])
    }
    
    @objc func closeTap(){
        dismiss(animated: true, completion: nil)
    }
    
    @objc func endEditing(){
        view.endEditing(true)
    }
    
}
