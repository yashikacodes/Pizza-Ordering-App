import UIKit

class OrderCell: UITableViewCell{
    @IBOutlet var primaryLabel : UILabel!
    @IBOutlet var secondaryLabel : UILabel!
    @IBOutlet var avatarImage : UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
}
