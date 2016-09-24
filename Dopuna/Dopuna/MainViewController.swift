//
//  MainViewController.swift
//  Dopuna
//
//  Created by admir WIP on 22/09/16.
//  Copyright © 2016 admir WIP. All rights reserved.
//

import UIKit

class MainViewController: UIViewController, ContactSelectedDelegate {
    
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
        if let contact = contact{
            chooseContactButton.setTitle(contact.name, forState: .Normal)
        }
        
    }
    
    func selectedContact(contact: Contact) {
        self.contact = contact
        print("\(contact.name)")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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

}

