//
//  MoveSimpleTableViewCell.swift
//  PokedexGo
//
//  Created by JIAWEI CHEN on 3/6/17.
//  Copyright © 2017 PokGear. All rights reserved.
//

import UIKit

class MoveSimpleTableViewCell: UITableViewCell {
    @IBOutlet weak var epsLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        if UIDevice.current.userInterfaceIdiom != .pad {
            epsLabel.removeFromSuperview()
        }
    }


}
