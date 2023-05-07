//
//  EvenTableViewCell.swift
//  Bubba
//
//  Created by Shrreya Ram on 23/04/23.
//

import UIKit

class EvenTableViewCell: UITableViewCell {
    
    @IBOutlet var label2 : UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        label2.numberOfLines = 0
        label2.layer.cornerRadius = 10
        label2.clipsToBounds = true
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
