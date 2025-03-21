//
//  OrderCell.swift
//  Assignment1-YashikaSaini
//
//  Created by Default User on 3/21/25.
//

import UIKit

class OrderCell: UITableViewCell {
    
    @IBOutlet var primaryLabel: UILabel!  // For displaying delivery date
    @IBOutlet var secondaryLabel: UILabel!  // For displaying address
    @IBOutlet var avatarImageView: UIImageView!  // For displaying avatar image
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        avatarImageView.layer.cornerRadius = avatarImageView.frame.size.width / 2
        avatarImageView.clipsToBounds = true
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}
