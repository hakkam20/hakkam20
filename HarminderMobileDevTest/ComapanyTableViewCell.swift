//
//  ComapanyTableViewCell.swift
//  HarminderMobileDevTest
//
//  Created by Singh, Harminder (external - Project) on 29/01/20.
//  Copyright © 2020 Singh, Harminder. All rights reserved.
//

import UIKit

class ComapanyTableViewCell: UITableViewCell {

    @IBOutlet weak var CompanyImage: UIImageView!
    @IBOutlet weak var CompanyName: UILabel!
    @IBOutlet weak var CompanyWebsite: UILabel!
    @IBOutlet weak var CompanyDescription: UILabel!
    @IBOutlet weak var btn_Favourite: UIButton!
    @IBOutlet weak var btn_Follow: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
