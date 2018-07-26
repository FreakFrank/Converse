//
//  SettingViewController.swift
//  Converse
//
//  Created by Kareem Ismail on 7/16/18.
//  Copyright © 2018 Whatever. All rights reserved.
//

import UIKit
import MessageUI

class SettingViewController: UIViewController, UITableViewDelegate, UITableViewDataSource,MFMailComposeViewControllerDelegate {
   
    
    @IBOutlet weak var infoLabel: UILabel!
    
    @IBOutlet weak var settingsLabel: UILabel!
    @IBOutlet weak var settingTableView: UITableView!
    let settingsTableElements = ["About Converse", "About FM2Apps LLC", "Terms and Conditions", "Send Feedback"]
    override func viewDidLoad() {
        super.viewDidLoad()
        settingTableView.delegate = self
        settingTableView.dataSource = self
    }
    @IBAction func backButtonPressed(_ sender: UIButton) {
            dismiss(animated: true, completion: nil)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return settingsTableElements.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            if let cell = settingTableView.dequeueReusableCell(withIdentifier: "settingsCell", for: indexPath) as? SettingsCell {
                cell.configureCell(with: settingsTableElements[indexPath.row])
                return cell
                
            } else {
                return UITableViewCell()
            }
        }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch indexPath.row {
        case 0 : performSegue(withIdentifier: TO_ABOUT_CONVERSE, sender: nil)
        case 1 : performSegue(withIdentifier: TO_ABOUT_US, sender: nil)
        case 2 : performSegue(withIdentifier: TO_TERMS, sender: nil)
        default : sendMail()
        }
        
    }
    func sendMail(){
        if MFMailComposeViewController.canSendMail(){
            let mail = MFMailComposeViewController()
            mail.mailComposeDelegate = self
            mail.setToRecipients(["info@fm2apps.com"])
            mail.setSubject("Converse App Feedback")
            present(mail, animated: true)
        }
    }
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        controller.dismiss(animated: true)
    }
    
}
