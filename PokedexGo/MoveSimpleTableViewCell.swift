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
        
        if UIDevice.current.userInterfaceIdiom != .pad {
            epsLabel.removeFromSuperview()
            epsLabel = nil
        }
    }
    
    func set(move: [String: Any]) {
        nameLabel.text = move["name"] as? String
        typeButton.set(move["type"] as! String)
        powerLabel.text = String(format: "%d", move["power"] as! Int)
        cdLabel.text = String(format: "%d", move["cd"] as! Int)
        dpsLabel.text = String(format: "%d", move["dps"] as! Int)
        if (epsLabel != nil) {
            epsLabel.text = String(format: "%d", move["eps"] as! Int)
        }
    }


}
