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

    func setStats(stats: NSDictionary) {
        stamina.text = stats.object(forKey: "stamina") as! String?
        attack.text = stats.object(forKey: "attack") as! String?
        defense.text = stats.object(forKey: "defense") as! String?
        maxcp.text = stats.object(forKey: "maxcp") as! String?
    }
   

}
