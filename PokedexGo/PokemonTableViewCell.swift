//
//  PokemonTableViewCell.swift
//  PokedexGo
//
//  Created by JIAWEI CHEN on 3/6/17.
//  Copyright © 2017 PokGear. All rights reserved.
//

import UIKit

class PokemonTableViewCell: UITableViewCell {

    @IBOutlet weak var pokemonImage: UIImageView!
    @IBOutlet weak var numLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var staminaLabel: UILabel!
    @IBOutlet weak var attackLabel: UILabel!
    @IBOutlet weak var defenseLabel: UILabel!
    @IBOutlet weak var maxcpLabel: UILabel!
    
    var toRemoveView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code 
        if UIDevice.current.userInterfaceIdiom != .pad {
            if toRemoveView != nil {
                toRemoveView.removeFromSuperview()
            }
            else {
                maxcpLabel.removeFromSuperview()
            }
            
            if UIScreen.main.bounds.width <= 320 {
                numLabel.removeFromSuperview()
                numLabel = nil
            }
        }
    }

    func set(pokemon: [String: Any]) {
        let num = pokemon["num"] as! NSInteger
        pokemonImage.downloadedFrom(url: PGHelper.imageUrlOfPokemon(width: 60, num: num))
        numLabel?.text = String(format: "#%03d", arguments: [num])
        nameLabel?.text = pokemon["name"] as? String
        staminaLabel?.text = String(pokemon["stamina"] as! Int)
        attackLabel?.text = String(pokemon["attack"] as! Int)
        defenseLabel?.text = String(pokemon["defense"] as! Int)
        maxcpLabel?.text = String(pokemon["maxcp"] as! Int)
   
    }
    

}
