//
//  TableViewCell.swift
//  Bubba
//
//  Created by Shrreya Ram on 29/04/23.
//

import UIKit

class TableViewCell: UITableViewCell {
    
    @IBOutlet var label1:UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        label1.numberOfLines = 0
        label1.layer.cornerRadius = 10
        label1.clipsToBounds = true
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
