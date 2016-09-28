//
//  MainViewController.swift
//  Dopuna
//
//  Created by admir WIP on 22/09/16.
//  Copyright © 2016 admir WIP. All rights reserved.
//

import UIKit
import MessageUI
class MainViewController: UIViewController, ContactSelectedDelegate, MFMessageComposeViewControllerDelegate, UINavigationControllerDelegate {
    
    // MARK: Properties
    
    @IBOutlet weak var chooseContactButton: UIButton!
    
    @IBOutlet weak var telecomunicationsSegControl: UISegmentedControl!
    
    @IBOutlet weak var amountSegControl: UISegmentedControl!
    
    @IBOutlet weak var sendMessageButton: UIButton!
    
   var contact: Contact?
   
    let mtel = [2,3,4,5,10]
    let bht = [1,2,5,10,20]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
            let greyBorder = UIColor(red: 208/255, green: 208/255, blue: 208/255, alpha: 1).CGColor
            let greenBlueBorder = UIColor(red: 83/255, green: 219/255, blue: 207/255, alpha: 1).CGColor
            chooseContactButton.layer.borderWidth = 1
            chooseContactButton.layer.cornerRadius = 6
            chooseContactButton.layer.borderColor = greyBorder
            telecomunicationsSegControl.layer.borderWidth = 1
            telecomunicationsSegControl.layer.cornerRadius = 4
            telecomunicationsSegControl.layer.borderColor = greyBorder
            amountSegControl.layer.borderWidth = 1
            amountSegControl.layer.cornerRadius = 4
            amountSegControl.layer.borderColor = greyBorder
            sendMessageButton.layer.borderWidth = 1
            sendMessageButton.layer.cornerRadius = 6
            sendMessageButton.layer.borderColor = greenBlueBorder
        
    }
    func selectedContact(contact: Contact){
        if contact.name != ""{
            chooseContactButton.setTitle(contact.name, forState: .Normal)
        }
        else{
            chooseContactButton.setTitle(contact.phoneNumber, forState: .Normal)
        }
        
        
        self.contact = contact
        
        let pozivni = contact.phoneNumber.substringToIndex(contact.phoneNumber.startIndex.advancedBy(5))
        switch pozivni {
        case "38760", "38761", "38762":
            telecomunicationsSegControl.setEnabled(true, forSegmentAtIndex: 1)
            telecomunicationsSegControl.selectedSegmentIndex = 1
            for i in 0...amountSegControl.numberOfSegments - 1{
                amountSegControl.setTitle("\(bht[i]) KM", forSegmentAtIndex: i)
                
            }
            telecomunicationsSegControl.setEnabled(false, forSegmentAtIndex: 0)
        case "38765", "38766":
            telecomunicationsSegControl.setEnabled(true, forSegmentAtIndex: 0)
            telecomunicationsSegControl.selectedSegmentIndex = 0
            for i in 0...amountSegControl.numberOfSegments - 1{
                amountSegControl.setTitle("\(mtel[i]) KM", forSegmentAtIndex: i)
                
            }
            telecomunicationsSegControl.setEnabled(false, forSegmentAtIndex: 1)
        default:
            print("")
        }
    }
        override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: Navigation
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if let tableViewController = segue.destinationViewController as? ContactsTableViewController{
            tableViewController.delegate = self
        }
    }
    
    
    
    // MARK: Actions
    
    @IBAction func telecomunicationsValueChangedSegControl(sender: UISegmentedControl) {
        
        switch telecomunicationsSegControl.selectedSegmentIndex {
        case 0:
            for i in 0...amountSegControl.numberOfSegments - 1{
                amountSegControl.setTitle("\(mtel[i]) KM", forSegmentAtIndex: i)
                
            }
        case 1:
            for i in 0...amountSegControl.numberOfSegments - 1{
                amountSegControl.setTitle("\(bht[i]) KM", forSegmentAtIndex: i)
                
            }
        default:
            print("unknown telecom")
        }
    }
    
    @IBAction func sendMessage(sender: UIButton) {
        if contact != nil{
            if !MFMessageComposeViewController.canSendText(){
                let alertController = UIAlertController(title: "Greska", message: "Ovaj uredjaj ne moze slati poruke", preferredStyle: .Alert)
                let okAction = UIAlertAction(title: "OK", style: .Default){
                    (action: UIAlertAction) in print("Pritisnuli ste OK dugme")
                }
                alertController.addAction(okAction)
                self.presentViewController(alertController, animated: true, completion: nil)
            }
            else{
                let composeVC = MFMessageComposeViewController()
                composeVC.messageComposeDelegate = self
                switch telecomunicationsSegControl.selectedSegmentIndex {
                case 0:
                    composeVC.recipients = ["0651110"]
                    composeVC.body = "D\(mtel[amountSegControl.selectedSegmentIndex]) \(contact!.phoneNumber)"
                case 1:
                    composeVC.recipients = ["0611171"]
                    composeVC.body = "\(bht[amountSegControl.selectedSegmentIndex]) \(contact!.phoneNumber)"
                
                default:
                print("Morate izabrati slanje kredita")
                }
                self.presentViewController(composeVC, animated: true, completion: nil)
            }
        }
    }
    
    func messageComposeViewController(controller: MFMessageComposeViewController, didFinishWithResult result: MessageComposeResult) {
        dismissViewControllerAnimated(true, completion: nil)
    }

}

