//
//  ItemCell.swift
//  Homepwner
//
//  Created by Ryan Zhang on 2016-02-15.
//  Copyright © 2016 Ryan Zhang. All rights reserved.
//

import UIKit

class ItemCell: UITableViewCell {
    @IBOutlet var nameLabel: UILabel!
    @IBOutlet var serialNumberLabel: UILabel!
    @IBOutlet var valueLabel: UILabel!

    func updateLabels() {
        let bodyFont = UIFont.preferredFontForTextStyle(UIFontTextStyleBody)
        nameLabel.font = bodyFont
        valueLabel.font = bodyFont
        let captionFont = UIFont.preferredFontForTextStyle(UIFontTextStyleCaption1)
        serialNumberLabel.font = captionFont
    }

    func setValueLabelColor(color: UIColor) {
        valueLabel.textColor = color
    }
}