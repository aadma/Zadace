//
//  Meal.swift
//  FoodTracker
//
//  Created by admir WIP on 10/09/16.
//  Copyright © 2016 Apple Inc. All rights reserved.
//

import UIKit

class Meal{
    
    // MARK: Properties
    
    var name: String
    var photo: UIImage?
    var rating: Int

    init?(name: String, photo: UIImage?, rating: Int){
        self.name = name
        self.photo = photo
        self.rating = rating
        if name.isEmpty || rating < 0{
            return nil
        }
    }
}
