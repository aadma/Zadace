//
//  Spend.swift
//  Spend Tracker
//
//  Created by admir WIP on 17/09/16.
//  Copyright © 2016 admir WIP. All rights reserved.
//

import Foundation

class Spend: NSObject, NSCoding{

    // MARK: Properties
    
    var amount: String
    var expenseDescription: String
    var dateSpent: String
    
    struct PropertyKey{
        static let amountKey = "amount"
        static let expenseDescriptionKey = "expenseDescription"
        static let dateSpentKey = "dateSpent"
    }
    // MARK: Archiving paths
    
    static let DocumentsDirectory = NSFileManager().URLsForDirectory(.DocumentDirectory, inDomains: .UserDomainMask).first!
    static let ArchiveURL = DocumentsDirectory.URLByAppendingPathComponent("expenses")

    // MARK: Initialisation
    
    init?(amount: String, expenseDescription: String, dateSpent: String){
        self.amount = amount
        self.expenseDescription = expenseDescription
        self.dateSpent = dateSpent
        super.init()
        if amount.isEmpty || expenseDescription.isEmpty || dateSpent.isEmpty{
            return nil
        }
    }
    // MARK: NSCoding
    
    func encodeWithCoder(aCoder: NSCoder){
            aCoder.encodeObject(amount, forKey: PropertyKey.amountKey)
           aCoder.encodeObject(expenseDescription, forKey: PropertyKey.expenseDescriptionKey)
            aCoder.encodeObject(dateSpent, forKey: PropertyKey.dateSpentKey)
    }
    required convenience init?(coder aDecoder: NSCoder){
        let amount = aDecoder.decodeObjectForKey(PropertyKey.amountKey) as! String
        let expDesc = aDecoder.decodeObjectForKey(PropertyKey.expenseDescriptionKey) as! String
        let dateSpent = aDecoder.decodeObjectForKey(PropertyKey.dateSpentKey) as! String
        self.init(amount: amount, expenseDescription: expDesc, dateSpent: dateSpent)
    }
}

