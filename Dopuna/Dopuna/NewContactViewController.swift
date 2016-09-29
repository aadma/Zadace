//
//  NewContactViewController.swift
//  Dopuna
//
//  Created by admir WIP on 27/09/16.
//  Copyright © 2016 admir WIP. All rights reserved.
//

import UIKit
protocol NewContactProtocol: class{
    func appendNewContact(contact: Contact)
}
class NewContactViewController: UIViewController {
    
    // MARK: Properties
    
    @IBOutlet weak var nameTextField: UITextField!
    
    @IBOutlet weak var numberTextfield: UITextField!
    
   
    weak var delegate: NewContactProtocol?
  
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        if segue.identifier == "saveSegue"{
        }
        
    }
    
    
    // MARK: Actions
    
    @IBAction func addContactBigButton(sender: UIButton) {
        addNewContact()
    }
    
    
    @IBAction func addContactSmallButton(sender: UIBarButtonItem) {
        addNewContact()
    }
    
    
    
    func addNewContact(){
        let name = nameTextField.text
        var number = numberTextfield.text ?? ""
        if number == ""{
            let alertController = UIAlertController(title: "Paznja", message: "Obavezno je unijeti broj telefona", preferredStyle: .Alert)
            let okAction = UIAlertAction(title: "OK", style: .Default){
                (action: UIAlertAction) in print("Pritisnuli ste OK dugme")}
            alertController.addAction(okAction)
            self.presentViewController(alertController, animated: true, completion: nil)
        }
        else{
            let potentialZeroStart = number.substringToIndex(number.startIndex.advancedBy(1))
            if potentialZeroStart == "0"{
                number = String(number.characters.dropFirst())
            }else{
                number = "387\(number)"
            }
            let newContact = Contact(name: name, phoneNumber: number)
            delegate?.appendNewContact(newContact!)
            navigationController?.popViewControllerAnimated(true)
            
        }

    }
    
    
    
    
}