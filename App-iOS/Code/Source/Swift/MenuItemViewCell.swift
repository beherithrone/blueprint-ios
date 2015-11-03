//
//  MenuItemViewCell.swift
//  App-iOS
//
//  Created by Pavel Jacko on 03/11/2015.
//  Copyright © 2015 Syerit Limited. All rights reserved.
//

import UIKit

class MenuItemViewCell: UITableViewCell {
       
  
    @IBOutlet weak var titleImage: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
