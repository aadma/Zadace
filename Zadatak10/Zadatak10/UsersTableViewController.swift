//
//  UsersTableViewController.swift
//  Zadatak10
//
//  Created by admir WIP on 12/10/16.
//  Copyright © 2016 admir WIP. All rights reserved.
//

import UIKit

class UsersTableViewController: UITableViewController {
    
    
    @IBAction func sendRequestForUsers(_ sender: UIBarButtonItem) {
        API.shared.refreshUsers()
    }
    
    var users = [User]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        NotificationCenter.default.addObserver(self, selector: #selector(UsersTableViewController.refreshData), name: NSNotification.Name("UsersRefreshed"), object: nil)
        
        
    }

    func refreshData(){
        users = Users.shared.users!
        tableView.reloadData()
    }
   
}
extension UsersTableViewController{
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        if let newUser = Users.shared.users{
            users.insert(newUser[0], at: 0)
            tableView.reloadData()
        }

}
    // MARK: - Table view data source
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return users.count
    }
    
   override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        
        // Configure the cell...
        
        let user = users[indexPath.row]
        
        cell.textLabel?.text = user.name
        cell.detailTextLabel?.text = user.email
        
        return cell
    }
    

    
}
