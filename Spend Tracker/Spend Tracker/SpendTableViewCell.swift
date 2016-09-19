//
//  SpendTableViewCell.swift
//  Spend Tracker
//
//  Created by admir WIP on 17/09/16.
//  Copyright © 2016 admir WIP. All rights reserved.
//

import UIKit

class SpendTableViewCell: UITableViewCell {
    
    // MARK: Properties
    
    @IBOutlet weak var dateOfExpenseLabel: UILabel!
        
    @IBOutlet weak var expenseDescriptionTextView: UITextView!

    @IBOutlet weak var amountSpentLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
