//
//  SpendTableViewController.swift
//  Spend Tracker
//
//  Created by admir WIP on 17/09/16.
//  Copyright © 2016 admir WIP. All rights reserved.
//

import UIKit

class SpendTableViewController: UITableViewController {
    // MARK: Properties
    var expenses = [Spend]()
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.leftBarButtonItem = editButtonItem()
        if let savedExpenses = loadExpenses(){
            expenses += savedExpenses
        }else{
        //load sample expenses
        loadSampleExpenses()
        }
    }
    func loadSampleExpenses(){
        let expense1 = Spend(amount: "30", expenseDescription: "headphones", dateSpent: "22.4.2016 12:15")!
        let expense2 = Spend(amount: "5", expenseDescription: "chicken", dateSpent: "25.5.2016 14:30")!
        let expense3 = Spend(amount: "3", expenseDescription: "lorem ipsum dolor sit amet lorem ipsum dolor sit amet lorem ispum dolor sit amet lorem ipsum dolor sit amet lorem ipsum dolor sit amet", dateSpent: "15.6.2016 10:15")!
        expenses += [expense1, expense2, expense3]
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
        return expenses.count
    }


    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cellIdentifier = "SpendTableViewCell"
        let cell = tableView.dequeueReusableCellWithIdentifier(cellIdentifier, forIndexPath: indexPath) as! SpendTableViewCell

        // Configure the cell...
        let expense = expenses[indexPath.row]
        cell.amountSpentLabel.text = String(expense.amount)
        cell.expenseDescriptionTextView.text = expense.expenseDescription
        cell.dateOfExpenseLabel.text = expense.dateSpent
        return cell
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
            expenses.removeAtIndex(indexPath.row)
            saveExpenses()
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
        if segue.identifier == "ShowDetail"{
            let spendDetailViewController = segue.destinationViewController as! SpendViewController
            //get the cell
            if let selectedExpenseCell = sender as? SpendTableViewCell{
                let indexPath = tableView.indexPathForCell(selectedExpenseCell)!
                let selectedExpense = expenses[indexPath.row]
                spendDetailViewController.spend = selectedExpense
            }
        }
        else if segue.identifier == "AddItem"{
            print("Adding expense")
        }
    }
    
    @IBAction func unwindToExpensesList(sender: UIStoryboardSegue){
        if let sourceViewController = sender.sourceViewController as? SpendViewController, spend = sourceViewController.spend{
            
            if let selectedIndexPath = tableView.indexPathForSelectedRow{
                //update existing expense
                expenses[selectedIndexPath.row] = spend
                tableView.reloadRowsAtIndexPaths([selectedIndexPath], withRowAnimation: .None)
            }
            else{
            
            let newIndexPath = NSIndexPath(forRow: expenses.count, inSection: 0)
            expenses.append(spend)
            tableView.insertRowsAtIndexPaths([newIndexPath], withRowAnimation: .Bottom)
            
            }
            saveExpenses()
        }
    }
    // MARK: NSCoding
    func saveExpenses(){
        let isSuccesfullSave = NSKeyedArchiver.archiveRootObject(expenses, toFile: Spend.ArchiveURL.path!)
        if !isSuccesfullSave{
            print("Failed to save expenses")
        }
    }
    func loadExpenses()-> [Spend]?{
        return NSKeyedUnarchiver.unarchiveObjectWithFile(Spend.ArchiveURL.path!) as? [Spend]
    }
}
