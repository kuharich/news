//
//  SummaryTableViewCell.swift
//  news
//
//  Created by Mark Kuharich on 7/23/18.
//  Copyright © 2018 Mark Kuharich. All rights reserved.
//

import UIKit

class SummaryTableViewCell: UITableViewCell {

    @IBOutlet weak var teaserImageView: UIImageView!
    @IBOutlet weak var headlineTextView: UITextView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
