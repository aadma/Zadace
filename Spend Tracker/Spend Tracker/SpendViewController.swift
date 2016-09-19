//
//  SpendViewController.swift
//  Spend Tracker
//
//  Created by admir WIP on 17/09/16.
//  Copyright © 2016 admir WIP. All rights reserved.
//

import UIKit

class SpendViewController: UIViewController, UITextFieldDelegate, UITextViewDelegate{
            // MARK: Properties
    
    @IBOutlet weak var titleLabel: UILabel!
        
    @IBOutlet weak var amountTextField: UITextField!
    
    @IBOutlet weak var descriptionTextView: UITextView!
    
    @IBOutlet weak var dateTitleLabel: UILabel!
    
    @IBOutlet weak var spendDatePicker: UIDatePicker!

    @IBOutlet weak var saveButton: UIBarButtonItem!
    
    let numberToolbar: UIToolbar = UIToolbar() // preparing to add buttons to decimalPad used on textfield
    
    var spend: Spend?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        amountTextField.delegate = self
        descriptionTextView.delegate = self
        if dateTitleLabel.text == "Date of the expense"{
            dateTitleLabel.text = showToday()
        }
        // adding toolbar buttons
        //numberToolbar.barStyle = UIBarStyle.BlackTranslucent
        numberToolbar.items = [
            UIBarButtonItem(title: "Cancel", style: UIBarButtonItemStyle.Plain, target: self, action: #selector(SpendViewController.decimalPadCancel)),
            UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.FlexibleSpace, target: self, action: nil),
            UIBarButtonItem(title: "Apply", style: UIBarButtonItemStyle.Plain, target: self, action: #selector(SpendViewController.decimalPadApply))
        ]
        numberToolbar.sizeToFit()
        amountTextField.inputAccessoryView = numberToolbar
        
        if let spend = spend{
            amountTextField.text = spend.amount
            descriptionTextView.text = spend.expenseDescription
            dateTitleLabel.text = spend.dateSpent
        }        
        
        // check if input fields are empty to disable the save button
        checkValidExpense()
    }
    
    // MARK: Navigation
    
    @IBAction func cancel(sender: UIBarButtonItem) {
        let isPresentingInAdd = presentingViewController is UINavigationController
        if isPresentingInAdd{
            dismissViewControllerAnimated(true, completion: nil)
        }else{
            navigationController!.popViewControllerAnimated(true)
        }
    }
    
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if saveButton === sender{
            let amount = amountTextField.text ?? ""
        let description = descriptionTextView.text ?? ""
            let dateSpent = dateTitleLabel.text ?? showToday()
            // prepare the data to be sent to SpendViewTableController after the unwind segue
            spend = Spend(amount: amount, expenseDescription: description, dateSpent: dateSpent)
        }
    }
    
    // MARK: Actions
    
    @IBAction func datePickerAction(sender: AnyObject) {
    let dateFormatter = NSDateFormatter()
    dateFormatter.dateFormat = "dd.MM.yyyy HH:mm"
    let strDate = dateFormatter.stringFromDate(spendDatePicker.date)
    dateTitleLabel.text = strDate
    
    }
    
    func decimalPadApply(){
        amountTextField.resignFirstResponder()
    }
    func decimalPadCancel(){
        amountTextField.text = ""
        amountTextField.resignFirstResponder()
    }
    // MARK: UITextFieldDelegate
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    func textFieldDidBeginEditing(textField: UITextField) {
        //disable save button while editing
        saveButton.enabled = false
    }
    func textFieldDidEndEditing(textField: UITextField) {
        checkValidExpense()
    }
    
    // MARK: UITextViewDelegate
    func textView(textView: UITextView, shouldChangeTextInRange range: NSRange, replacementText text: String) -> Bool {
        if text == "\n"{
            textView.resignFirstResponder()
            checkValidExpense()
            return false
        }
        return true
    }
    
        // MARK: NSDate
    func showToday()->String{
        let today = NSDate()
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "dd.MM.yyyy HH:mm"
        let strDate = dateFormatter.stringFromDate(today)
        return strDate
    }
    
    // MARK: Helper functions
    func checkValidExpense(){
        let amount = amountTextField.text ?? ""
        let description = descriptionTextView.text ?? ""
        saveButton.enabled = (!amount.isEmpty && !description.isEmpty)
        
    }
}

