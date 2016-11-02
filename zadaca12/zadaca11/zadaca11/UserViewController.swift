//
//  UserViewController.swift
//  zadaca11
//
//  Created by admir WIP on 25/10/16.
//  Copyright © 2016 admir WIP. All rights reserved.
//

import UIKit

class UserViewController: UIViewController,UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var icon: UIImageView!
    
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var nameLabel: UILabel!
    var user: User!
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        user = UserProfile.shared.userProfile
        nameLabel.text = user.name
        let rand = Int(arc4random_uniform(2) + 1)
        if rand == 2{
        icon.image = #imageLiteral(resourceName: "icon1")
        } else {
        icon.image = #imageLiteral(resourceName: "icon2")
        }
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 7
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        let row = indexPath.row
        switch row{
        case 0:
            cell.textLabel?.text = "Name"
            cell.detailTextLabel?.text = user.name
        case 1:
            cell.textLabel?.text = "Username"
            cell.detailTextLabel?.text = user.username
        case 2:
            cell.textLabel?.text = "Email"
            cell.detailTextLabel?.text = user.email
        case 3:
            cell.textLabel?.text = "Address"
            if let street = user.address?.street, let city = user.address?.city{
                cell.detailTextLabel?.text = street + ", " + city
            }
        case 4:
            cell.textLabel?.text = "Phone"
            cell.detailTextLabel?.text = user.phone
        case 5:
            cell.textLabel?.text = "Website"
            cell.detailTextLabel?.text = user.website
        case 6:
            cell.textLabel?.text = "Company"
            if let companyName = user.company?.name{
                cell.detailTextLabel?.text = companyName
            }
        default: break
        }
        return cell
    }
    
}
