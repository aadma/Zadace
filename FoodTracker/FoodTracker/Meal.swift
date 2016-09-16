//
//  Meal.swift
//  FoodTracker
//
//  Created by admir WIP on 10/09/16.
//  Copyright © 2016 Apple Inc. All rights reserved.
//

import UIKit

class Meal: NSObject, NSCoding{
    
    // MARK: Properties
   
    var name: String
    var photo: UIImage?
    var rating: Int
    
    // MARK: Archiving paths
    
    static let DocumentsDirectory = NSFileManager().URLsForDirectory(.DocumentDirectory, inDomains: .UserDomainMask).first!
    static let ArcihveURL = DocumentsDirectory.URLByAppendingPathComponent("meals")
   
    init?(name: String, photo: UIImage?, rating: Int){
        self.name = name
        self.photo = photo
        self.rating = rating
        super.init()
        if name.isEmpty || rating < 0{
            return nil
        }
    }
    
    func encodeWithCoder(aCoder: NSCoder) {
        aCoder.encodeObject(name, forKey: PropertyKey.nameKey)
        aCoder.encodeObject(photo, forKey: PropertyKey.photoKey)
        aCoder.encodeInteger(rating, forKey: PropertyKey.ratingKey)
    }
    required convenience init?(coder aDecoder: NSCoder) {
        let name = aDecoder.decodeObjectForKey(PropertyKey.nameKey) as! String
        let photo = aDecoder.decodeObjectForKey(PropertyKey.photoKey) as? UIImage
        let rating = aDecoder.decodeIntegerForKey(PropertyKey.ratingKey)
        self.init(name: name, photo: photo, rating: rating)
    }
}

struct PropertyKey{
    static let nameKey = "name"
    static let photoKey = "photo"
    static let ratingKey = "rating"
}