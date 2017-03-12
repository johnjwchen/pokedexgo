//
//  DescriptionTableViewCell.swift
//  PokedexGo
//
//  Created by JIAWEI CHEN on 3/7/17.
//  Copyright © 2017 PokGear. All rights reserved.
//

import UIKit

class DescriptionTableViewCell: UITableViewCell {
    @IBOutlet weak var descriptLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func set(description: String) {
        descriptLabel.text = description
    }
}
