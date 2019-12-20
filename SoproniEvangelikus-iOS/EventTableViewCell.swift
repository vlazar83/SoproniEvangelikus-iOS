//
//  EventTableViewCell.swift
//  SoproniEvangelikus-iOS
//
//  Created by admin on 2019. 12. 20..
//  Copyright © 2019. admin. All rights reserved.
//

import UIKit

class EventTableViewCell: UITableViewCell {
    
    //MARK: Properties
    
    @IBOutlet weak var eventNameLabel: UILabel!
    @IBOutlet weak var eventFullNameLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
