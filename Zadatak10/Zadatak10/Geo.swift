//
//  Geo.swift
//  Zadatak10
//
//  Created by admir WIP on 12/10/16.
//  Copyright © 2016 admir WIP. All rights reserved.
//

import UIKit

class Geo: NSObject {
    
    var lat: String?
    var lng: String?
    
    init(lat: String, lng: String) {
        self.lat = lat
        self.lng = lng
    }
    override init(){
        super.init()
    }


}
