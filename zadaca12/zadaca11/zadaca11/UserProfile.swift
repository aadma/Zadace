//
//  UserProfile.swift
//  zadaca11
//
//  Created by admir WIP on 26/10/16.
//  Copyright © 2016 admir WIP. All rights reserved.
//

import UIKit

class UserProfile: NSObject {
    static var shared = UserProfile()
    var userProfile: User?
    
    override private init(){
        super.init()
    }
    
}
