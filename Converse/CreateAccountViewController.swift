//
//  CreateAccountViewController.swift
//  Converse
//
//  Created by Kareem Ismail on 8/20/17.
//  Copyright © 2017 Whatever. All rights reserved.
//

import UIKit

class CreateAccountViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

    }

    @IBAction func cancelButtonPressed(_ sender: Any) {
        performSegue(withIdentifier: UNWIND_TO_CHANNEL, sender: nil)
    }

}
