//
//  UserViewController.swift
//  Zadatak10
//
//  Created by admir WIP on 12/10/16.
//  Copyright © 2016 admir WIP. All rights reserved.
//

import UIKit

class UserViewController: UIViewController {
    
    @IBOutlet weak var nameTextField: UITextField!
    
    @IBOutlet weak var emailTextField: UITextField!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @IBAction func save(_ sender: UIButton) {
        guard nameTextField.text?.isEmpty == false && emailTextField.text?.isEmpty == false else {
            return
        }
        let user = User()
        user.name = nameTextField.text
        user.email = emailTextField.text
        Users.shared.users?.insert(user, at: 0)
       
        navigationController!.popViewController(animated: true)
    }
    

}
