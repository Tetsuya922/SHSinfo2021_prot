//
//  CustomCellTableViewCell.swift
//  SHSinfo2021
//
//  Created by 吉川哲也 on 2021/12/09.
//  Copyright © 2021 SHS情報技術. All rights reserved.
//

import UIKit

class CustomCellTableViewCell: UITableViewCell {


    @IBOutlet weak var myImageView: UIImageView!
    @IBOutlet weak var myLabel: UILabel!

    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

