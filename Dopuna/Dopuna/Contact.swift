//
//  Contact.swift
//  Dopuna
//
//  Created by admir WIP on 22/09/16.
//  Copyright © 2016 admir WIP. All rights reserved.
//

import Foundation

class Contact: NSObject, NSCoding{
    // MARK: Properties
    
    var name: String?
    var phoneNumber: String
    
    // MARK: Archiving paths
    
    static let DocumentsDirectory = NSFileManager().URLsForDirectory(.DocumentDirectory, inDomains: .UserDomainMask).first!
    static let ArchiveURL = DocumentsDirectory.URLByAppendingPathComponent("contacts")
    
    // MARK: Init
    
    init?(name: String?, phoneNumber: String){
        self.name = name
        self.phoneNumber = phoneNumber
        if phoneNumber.isEmpty {
            return nil
        }
    }
    
    // MARK: Types
    
    struct PropertyKey{
        static let nameKey = "name"
        static let phoneKey = "phoneNumber"
    }
    
    // MARK: NSCoding
    func encodeWithCoder(aCoder: NSCoder) {
        aCoder.encodeObject(name, forKey: PropertyKey.nameKey)
        aCoder.encodeObject(phoneNumber, forKey: PropertyKey.phoneKey)
    }
    
    required convenience init?(coder aDecoder: NSCoder){
        let name = aDecoder.decodeObjectForKey(PropertyKey.nameKey) as? String
        let phoneNumber = aDecoder.decodeObjectForKey(PropertyKey.phoneKey) as! String
        self.init(name: name, phoneNumber: phoneNumber)
    }
}

