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
    @IBOutlet weak var typeButton: PTTypeButton!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var powerLabel: UILabel!
    @IBOutlet weak var cdLabel: UILabel!
    @IBOutlet weak var dpsLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func set(move: [String: Any]) {
        nameLabel.text = move["name"] as? String
        typeButton.set(move["type"] as! String)
        powerLabel.text = String(move["power"] as! Int)
        cdLabel.text = String(move["cd"] as! Float)
        dpsLabel.text = String(move["dps"] as! Float)
        if (epsLabel != nil) {
            epsLabel.text = String(move["eps"] as! Float)
        }
    }


}
