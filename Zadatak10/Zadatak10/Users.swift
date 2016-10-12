//
//  Users.swift
//  Zadatak10
//
//  Created by admir WIP on 12/10/16.
//  Copyright © 2016 admir WIP. All rights reserved.
//

import UIKit

class Users: NSObject {
    
    static var shared = Users()
    
    var users: [User]?
    
    override private init(){
        super.init()
    }
}
