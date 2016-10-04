//
//  PostsTableViewController.swift
//  zadaca9
//
//  Created by admir WIP on 04/10/16.
//  Copyright © 2016 admir WIP. All rights reserved.
//

import UIKit

class PostsTableViewController: UITableViewController{
    var posts = [Post]()
    var user: User!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let url = NSURL(string: "https://jsonplaceholder.typicode.com/posts?userId=\(user.id!)")!
        NSURLSession.sharedSession().dataTaskWithURL(url) { (data:NSData?
            , response: NSURLResponse?, error: NSError?) in
            
            if let error = error{
                print(error)
            }
            else{
                do{
                    let json = try NSJSONSerialization.JSONObjectWithData(data!, options: .AllowFragments) as! [[String: AnyObject]]
                                       
                    for postObj in json{
                        let post = Post()
                        if let title = postObj["title"] as? String{
                            post.title = title
                        }
                        if let userId = postObj["userId"] as? Int{
                            post.userId = userId
                        }
                        if let id = postObj["id"] as? Int{
                            post.id = id
                        }
                        if let body = postObj["body"] as? String{
                            post.body = body
                        }
                        self.posts.append(post)
                        
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
        return posts.count
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("PostsCell", forIndexPath: indexPath)

        let newPost = posts[indexPath.row]
        cell.textLabel?.text = newPost.title
        cell.detailTextLabel?.text = newPost.body

        return cell
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

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
}
