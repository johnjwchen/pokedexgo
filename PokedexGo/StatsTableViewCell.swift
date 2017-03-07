//
//  StatsTableViewCell.swift
//  PokedexGo
//
//  Created by JIAWEI CHEN on 3/3/17.
//  Copyright © 2017 PokGear. All rights reserved.
//

import UIKit

class StatsTableViewCell: UITableViewCell {
    @IBOutlet weak var stamina: UILabel!
    @IBOutlet weak var attack: UILabel!
    @IBOutlet weak var defense: UILabel!
    @IBOutlet weak var maxcp: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func set(stats: [String: Any]) {
        stamina.text = String(stats["stamina"] as! Int)
        attack.text = String(stats["attack"] as! Int)
        defense.text = String(stats["defense"] as! Int)
        maxcp.text = String(stats["maxcp"] as! Int)
    }
   

}
