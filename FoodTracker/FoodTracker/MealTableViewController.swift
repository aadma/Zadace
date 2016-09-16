//
//  MealTableViewController.swift
//  FoodTracker
//
//  Created by admir WIP on 15/09/16.
//  Copyright © 2016 Apple Inc. All rights reserved.
//

import UIKit

class MealTableViewController: UITableViewController {
    
    // MARK: Propeties
    
    var meals = [Meal]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.leftBarButtonItem = editButtonItem()
        // If there are saved meals load them else load sample meals only
        if let savedMeals = loadMeals(){
            meals += savedMeals
        }
        else{
        loadSampleMeals()
        }
    }
    
    func loadSampleMeals(){
        let photo1 = UIImage(named: "meal1")
        let meal1 = Meal(name: "Caprice salad", photo: photo1, rating: 4)!
        let photo2 = UIImage(named: "meal2")
        let meal2 = Meal(name: "Chicken and potatoes", photo: photo2, rating: 5)!
        let photo3 = UIImage(named: "meal3")
        let meal3 = Meal(name: "Pasta with meatballs", photo: photo3, rating: 3)!
        meals += [meal1, meal2, meal3]
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
        return meals.count
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        //remember the nickname(identifier) we gave to cell(from identity inspector)
        let cellIdentifier = "MealTableViewCell"
        //define cell and cast it to mealtableviewcell
        let cell = tableView.dequeueReusableCellWithIdentifier(cellIdentifier, forIndexPath: indexPath) as! MealTableViewCell
        let meal = meals[indexPath.row]
        cell.nameLabel.text = meal.name
        cell.photoImageView.image = meal.photo
        cell.ratingControl.rating = meal.rating
        // Configure the cell...

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
            meals.removeAtIndex(indexPath.row)
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
            saveMeals()
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
        if segue.identifier == "ShowDetail"{
            let mealDetailViewController = segue.destinationViewController as! MealViewController
            // get the cell that generated this segue
            if let selectedMealCell = sender as? MealTableViewCell{
                let indexPath = tableView.indexPathForCell(selectedMealCell)!
                let selectedMeal = meals[indexPath.row]
                mealDetailViewController.meal = selectedMeal
            }
        }
        else if segue.identifier == "AddItem"{
            print("Adding new meal")
        }
    }
    
    @IBAction func unwindToMeallist(sender: UIStoryboardSegue){
        if let sourceViewController = sender.sourceViewController as? MealViewController, meal = sourceViewController.meal{
            if let selectedIndexPath = tableView.indexPathForSelectedRow{
                // update meals
                meals[selectedIndexPath.row] = meal
                tableView.reloadRowsAtIndexPaths([selectedIndexPath], withRowAnimation: .None)
            }
            else{
                //add a new meal
                let newIndexPath = NSIndexPath(forRow: meals.count, inSection: 0)
                meals.append(meal)
                tableView.insertRowsAtIndexPaths([newIndexPath], withRowAnimation: .Bottom)
            }
            saveMeals()
        }
    }
    
    // MARK: NSCoding save and load
    
    func saveMeals(){
        let isSuccessfullSave = NSKeyedArchiver.archiveRootObject(meals, toFile: Meal.ArcihveURL.path!)
        if isSuccessfullSave == false{
            print("Failed to save data")
        }
    }
    func loadMeals()->[Meal]?{
        return NSKeyedUnarchiver.unarchiveObjectWithFile(Meal.ArcihveURL.path!) as? [Meal]
    }
}
