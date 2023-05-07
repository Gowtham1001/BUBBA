//
//  HomeTableViewCell.swift
//  Bubba
//
//  Created by Shrreya Ram on 03/05/23.
//

import UIKit

class HomeTableViewCell: UITableViewCell {
    
    
    @IBOutlet weak var mainImage: UIImageView!
    @IBOutlet weak var mainText: UILabel!
    @IBOutlet weak var subText: UILabel!
    @IBOutlet weak var miniText: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
