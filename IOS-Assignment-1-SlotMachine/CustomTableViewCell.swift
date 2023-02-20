//
//  CustomTableViewCell.swift
//  IOS-Assignment-1-SlotMachine
//
//  Created by Krisuv Bohara on 2023-02-19.
//

import UIKit

class CustomTableViewCell: UITableViewCell {
    
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var payoutLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
