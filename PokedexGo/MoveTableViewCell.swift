//
//  MoveTableViewCell.swift
//  PokedexGo
//
//  Created by JIAWEI CHEN on 3/3/17.
//  Copyright © 2017 PokGear. All rights reserved.
//

import UIKit

class MoveTableViewCell: UITableViewCell {
    @IBOutlet weak var lastView: UIView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var typeButton: PTTypeButton!
    @IBOutlet weak var powerLabel: UILabel!
    @IBOutlet weak var cdLabel: UILabel!
    @IBOutlet weak var dpsLabel: UILabel!
    @IBOutlet weak var epsLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        if UIDevice.current.userInterfaceIdiom != .pad {
            lastView.removeFromSuperview()
        }
    }
    
    func set(move: [String: Any]) {
        nameLabel.text = move["name"] as? String
        typeButton.set(move["type"] as? String)
        powerLabel?.text = String(move["power"] as! Int)
        cdLabel?.text = String(move["cd"] as! Float)
        dpsLabel?.text = String(move["dps"] as! Float)
        epsLabel?.text = String(move["eps"] as! Float)
    }
}
