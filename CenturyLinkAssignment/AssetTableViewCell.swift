//
//  AssetTableViewCell.swift
//  CenturyLinkAssignment
//
//  Created by Swagat Mishra on 4/22/18.
//  Copyright © 2018 Swagat Mishra. All rights reserved.
//

import UIKit

class AssetTableViewCell: UITableViewCell {

    @IBOutlet weak var productImageView: UIImageView!
    @IBOutlet weak var assetName: UILabel!
    @IBOutlet weak var assetId: UILabel!
    @IBOutlet weak var assetLocation: UILabel!
    @IBOutlet weak var locationImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }

}
