//
//  HeaderTableViewCell.swift
//  SampleBFM
//
//  Created by SELMI Oussama on 08/04/2018.
//  Copyright © 2018 Next Radio TV. All rights reserved.
//

import UIKit

class HeaderTableViewCell: UITableViewCell {

    @IBOutlet weak var titleArticle: UILabel!
    @IBOutlet weak var headerImage: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        titleArticle.layer.shadowOffset = CGSize(width: 1, height: 1)
        titleArticle.layer.shadowOpacity = 0.3
        titleArticle.layer.shadowRadius = 2

    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
