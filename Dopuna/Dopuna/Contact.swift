//
//  Contact.swift
//  Dopuna
//
//  Created by admir WIP on 22/09/16.
//  Copyright © 2016 admir WIP. All rights reserved.
//

import Foundation

class Contact{

    var name: String?
    var phoneNumber: String
    
    init?(name: String?, phoneNumber: String){
        self.name = name
        self.phoneNumber = phoneNumber
        if phoneNumber.isEmpty {
            return nil
        }
    }
}

protocol ContactSelectedDelegate{
   func selectedContact(contact: Contact)
}