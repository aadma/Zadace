//
//  RatingControl.swift
//  FoodTracker
//
//  Created by admir WIP on 09/09/16.
//  Copyright © 2016 Apple Inc. All rights reserved.
//

import UIKit

class RatingControl: UIView {
    
    // MARK: Properties
    
    var rating = 0
    var ratingButtons = [UIButton]()
    let spacing = 5
    let starCount = 5
    
    // MARK: Initialization
    
    required init?(coder aDecoder: NSCoder){
        super.init(coder: aDecoder)
        let filledStarImage = UIImage(named: "filledStar")
        let emptyStarImage = UIImage(named: "emptyStar")
        for _ in 0..<starCount{
        let button = UIButton()
        button.setImage(emptyStarImage, forState: .Normal)
        button.setImage(filledStarImage, forState: .Selected)
        button.setImage(filledStarImage, forState: [.Highlighted, .Selected])
        button.adjustsImageWhenHighlighted = false
        button.addTarget(self, action: #selector(RatingControl.ratingButtonTapped(_:)), forControlEvents: .TouchDown)
            ratingButtons.append(button)
        self.addSubview(button)
        }
    }
    
    override func intrinsicContentSize() -> CGSize {
        let buttonSize = Int(frame.size.height)
        let width = (buttonSize * starCount) + (spacing * (spacing - 1) )
        return CGSize(width: width, height: buttonSize)
    }
    
    override func layoutSubviews() {
        let buttonSize = Int(frame.size.height)
        var buttonFrame = CGRect(x: 0, y: 0, width: buttonSize, height: buttonSize)
        for (index, button) in ratingButtons.enumerate(){
            buttonFrame.origin.x = CGFloat(index * (44 + spacing))
            button.frame = buttonFrame
        }
        updateButtonSelectionStates()
    }
    
    func ratingButtonTapped(button: UIButton){
        rating = ratingButtons.indexOf(button)! + 1
        updateButtonSelectionStates()
    }
    
    func updateButtonSelectionStates(){
        for (index, button) in ratingButtons.enumerate(){
            button.selected = index < rating
        }
    }
}
