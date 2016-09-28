//
//  ContactsTableViewController.swift
//  Dopuna
//
//  Created by admir WIP on 23/09/16.
//  Copyright © 2016 admir WIP. All rights reserved.
//

import UIKit
protocol ContactSelectedDelegate: class{
    func selectedContact(contact: Contact)
    }
class ContactsTableViewController: UITableViewController, NewContactProtocol {
    
    var contacts = [Contact]()
    weak var delegate: ContactSelectedDelegate?
    

    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let savedContacts = loadContacts(){
            contacts += savedContacts
        }
        else{
        loadSampleContacts()
        }
        // Uncomment the following line to preserve selection between presentations
       // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view
        //let addBtn: UIBarButtonItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.Add, target: self, action: nil)
        //self.navigationItem.setRightBarButtonItems([addBtn ,self.editButtonItem()], animated: true)
    }
    func loadSampleContacts(){
        let contact1 = Contact(name: "Admir", phoneNumber: "38761123123")!
        let contact2 = Contact(name: "", phoneNumber: "38761123456")!
        let contact3 = Contact(name: "Belmin", phoneNumber: "38762789012")!
        let contact4 = Contact(name: "Ena", phoneNumber: "38765345678")!
        let contact5 = Contact(name: "Merima", phoneNumber: "38766901234")!
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
        
           
            let selectedcell = tableView.cellForRowAtIndexPath(indexPath)!
        
                selectedcell.accessoryType = .Checkmark
                
        delegate?.selectedContact(selectedContactInTable)

    }
    
    override func tableView(tableView: UITableView, didDeselectRowAtIndexPath indexPath: NSIndexPath) {
    
        let selectedcell = tableView.cellForRowAtIndexPath(indexPath)!
        selectedcell.accessoryType = .None
    }
        
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
 

    
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            contacts.removeAtIndex(indexPath.row)
            saveContacts()
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    

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
   override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
                
     if let newContactsController = segue.destinationViewController as? NewContactViewController{
        newContactsController.delegate = self
     }

    }
    
    func appendNewContact(contact: Contact) {
        let newIndexPath = NSIndexPath(forRow: contacts.count, inSection: 0)
        contacts.append(contact)
        tableView.insertRowsAtIndexPaths([newIndexPath], withRowAnimation: .Bottom)
        saveContacts()
    }
    
    override func setEditing(editing: Bool, animated: Bool) {
        super.setEditing(editing, animated: animated)
    }
    
    // MARK: Actions
    
    @IBAction func editMode(sender: UIBarButtonItem) {
        if tableView.editing == false{
        setEditing(true, animated: true)
           sender.title = "Done"
        }
        else{
        setEditing(false, animated: true)
            sender.title = "Edit"
        }
    }
    
    // MARK: NSCoding
    
    func saveContacts(){
        let isSuccessfulSave = NSKeyedArchiver.archiveRootObject(contacts, toFile: Contact.ArchiveURL.path!)
        if !isSuccessfulSave{
            print("Failed to save contact")
        }
    }
    
    func loadContacts() ->[Contact]?{
        return NSKeyedUnarchiver.unarchiveObjectWithFile(Contact.ArchiveURL.path!) as? [Contact]
    }
}
