//
//  ContactsTableViewController.swift
//  Dopuna
//
//  Created by admir WIP on 23/09/16.
//  Copyright © 2016 admir WIP. All rights reserved.
//

import UIKit

class ContactsTableViewController: UITableViewController {
    var contacts = [Contact]()
    var delegate: ContactSelectedDelegate?
    override func viewDidLoad() {
        super.viewDidLoad()
        loadSampleContacts()
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }
    func loadSampleContacts(){
        let contact1 = Contact(name: "Admir", phoneNumber: "060123123")!
        let contact2 = Contact(name: "Kenan", phoneNumber: "061123456")!
        let contact3 = Contact(name: "Belmin", phoneNumber: "062789012")!
        let contact4 = Contact(name: "Ena", phoneNumber: "065345678")!
        let contact5 = Contact(name: "Merima", phoneNumber: "066901234")!
        contacts += [contact1, contact2, contact3, contact4, contact5]
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return contacts.count
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cellIdentifier = "ContactTableViewCell"
        let cell = tableView.dequeueReusableCellWithIdentifier(cellIdentifier, forIndexPath: indexPath)
        
        // Configure the cell...
        let contact = contacts[indexPath.row]
        cell.textLabel!.text = contact.name
        cell.detailTextLabel!.text = contact.phoneNumber
        return cell
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let selectedContactInTable = contacts[indexPath.row]
        delegate?.selectedContact(selectedContactInTable)
       
    

    }
    
    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */
    
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
   /* override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        if segue.identifier == "selectedContact"{
           
                let mainController = segue.destinationViewController as! MainViewController
            if let selectedCell = sender as? ContactTableViewCell{
                let indexPath = tableView.indexPathForCell(selectedCell)!
                let selectedContact = contacts[indexPath.row]
                selectedCell.accessoryType = .Checkmark 
                mainController.contact = selectedContact
                
            }
        
        
        }
    }*/
    
}
