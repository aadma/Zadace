//
//  API.swift
//  Zadatak10
//
//  Created by admir WIP on 12/10/16.
//  Copyright © 2016 admir WIP. All rights reserved.
//

import UIKit

class API: NSObject {
    
    static var shared = API()
    
    override private init(){
        super.init()
    }
    
    func refreshUsers(){
    // instantiate ServerCommunication and call its method
        let serverCommunication = ServerCommunication()
        serverCommunication.refreshUsers()
    }

}
