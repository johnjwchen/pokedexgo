//
//  MoveNameTableViewCell.swift
//  PokedexGo
//
//  Created by JIAWEI CHEN on 3/7/17.
//  Copyright © 2017 PokGear. All rights reserved.
//

import UIKit

class MoveNameTableViewCell: UITableViewCell {

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var typeButton: PTTypeButton!
    @IBOutlet weak var categoryLabel: UILabel!
    

    @IBOutlet weak var powerLabel: UILabel!
    @IBOutlet weak var cdLabel: UILabel!
    @IBOutlet weak var dpsLabel: UILabel!
    @IBOutlet weak var epsLabel: UILabel!

    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func set(info: [String: Any]) {
        nameLabel?.text = info["name"] as? String
        typeButton?.set(info["type"] as! String)
        categoryLabel?.text = info["category"] as? String
        
        powerLabel?.text = String(info["power"] as! Int)
        cdLabel?.text = String(info["cd"] as! Float)
        dpsLabel?.text = String(info["dps"] as! Float)
        epsLabel?.text = String(info["eps"] as! Float)
    }
}
