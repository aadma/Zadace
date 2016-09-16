//
//  FoodTrackerTests.swift
//  FoodTrackerTests
//
//  Created by Jane Appleseed on 5/23/15.
//  Copyright © 2015 Apple Inc. All rights reserved.
//

import XCTest
import UIKit
class FoodTrackerTests: XCTestCase {
    
    // MARK: FoodTracker tests
    
    func testMealinitialization(){
    
        let potentialItem = Meal(name: "Some meal", photo: nil, rating: 4)
        XCTAssertNotNil(potentialItem)
        
        let noName = Meal(name: "", photo: nil, rating: 2)
        XCTAssertNil(noName)
        
        let badRating = Meal(name: "Another meal", photo: nil, rating: -1)
        XCTAssertNil(badRating)
    }
    
    
}
