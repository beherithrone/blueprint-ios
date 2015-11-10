//
//  AwsViewCell.swift
//  App_iOS
//
//  Created by Pavel Jacko on 10/11/2015.
//  Copyright © 2015 Syerit. All rights reserved.
//

import UIKit

class AwsViewCell: UITableViewCell {

    @IBOutlet weak var cellLabel: UILabel!
    @IBOutlet weak var cellImage: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
