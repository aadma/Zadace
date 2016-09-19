//
//  MealTableViewCell.swift
//  Spend Tracker
//
//  Created by admir WIP on 17/09/16.
//  Copyright © 2016 admir WIP. All rights reserved.
//

import UIKit

class MealTableViewCell: UITableViewCell {
    
    // MARK: Properties
    
    @IBOutlet weak var amountSpentLabel: UILabel!
    
    @IBOutlet weak var expenseDescriptionLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
