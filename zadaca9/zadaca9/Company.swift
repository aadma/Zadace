//
//  Company.swift
//  zadaca9
//
//  Created by admir WIP on 04/10/16.
//  Copyright © 2016 admir WIP. All rights reserved.
//

import UIKit

class Company: NSObject {
    var name: String?
    var catchPhrase: String?
    var bs: String?
    
    init(name: String, catchPhrase: String, bs: String) {
        self.name = name
        self.catchPhrase = catchPhrase
        self.bs = bs
    }
    override init(){
        super.init()
    }

}
