//
//  MemberTableViewCell.swift
//  HarminderMobileDevTest
//
//  Created by Singh, Harminder (external - Project) on 29/01/20.
//  Copyright © 2020 Singh, Harminder. All rights reserved.
//

import UIKit

class MemberTableViewCell: UITableViewCell {

    @IBOutlet weak var MemberName: UILabel!
    @IBOutlet weak var MemberAge: UILabel!
    @IBOutlet weak var MemberPhone: UILabel!
    @IBOutlet weak var MemberEmail: UILabel!
    @IBOutlet weak var MemberFavourite: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
