//
//  ViewController.swift
//  zadaca9
//
//  Created by admir WIP on 03/10/16.
//  Copyright © 2016 admir WIP. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    var users = [User]()
    var userToSend: User?
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
                super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func sendRequestForUsers(sender: UIBarButtonItem) {
        let url = NSURL(string: "http://jsonplaceholder.typicode.com/users")!
        NSURLSession.sharedSession().dataTaskWithURL(url) { (data:NSData?
            , response: NSURLResponse?, error: NSError?) in
            
            if let error = error{
                print(error)
            }
            else{
                do{
                    let json = try NSJSONSerialization.JSONObjectWithData(data!, options: .AllowFragments) as! [[String: AnyObject]]
                    // reset array
                    self.users = [User]()
                    
                    // get each user
                    for userObj in json{
                        
                        let user = User()
                        if let id = userObj["id"] as? Int{
                            user.id = id
                        }
                        if let name = userObj["name"] as? String{
                            user.name = name
                        }
                        if let username = userObj["username"] as? String{
                            user.username = username
                        }
                        if let email = userObj["email"] as? String{
                            user.email = email
                        }
                        if let addressObj = userObj["address"] as? [String: AnyObject]{
                            let address = Address()
                            user.address = address
                            if let street = addressObj["street"] as? String{
                                address.street = street
                            }
                            if let geoObj = addressObj["geo"] as? [String: AnyObject]{
                                let geo = Geo()
                                address.geo = geo
                                if let lat = geoObj["lat"] as? String{
                                    geo.lat = lat
                                }
                                if let lng = geoObj["lng"] as? String{
                                    geo.lng = lng
                                }
                            }
                        }
                        self.users.append(user)
                     
                    }
                   dispatch_sync(dispatch_get_main_queue(), { 
                    self.tableView.reloadData()
                   })

                }catch{
                    print(error)
                }
            }
        }.resume()
        
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.users.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell")
        let user = users[indexPath.row]
        cell?.textLabel?.text = user.name!
        cell?.detailTextLabel?.text = user.address?.street!
        return cell!
    }
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
     userToSend = users[indexPath.row]
        self.performSegueWithIdentifier("sendUser", sender: self)
    }
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "sendUser"{
            if let destination = segue.destinationViewController as? PostsTableViewController{
            destination.user = userToSend
            }
        }
    }
}

