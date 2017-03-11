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
    @IBOutlet weak var type1Button: PTTypeButton!
    @IBOutlet weak var type2Button: PTTypeButton!
    
    @IBOutlet weak var stackView: UIStackView!
    
    @IBOutlet weak var numWidthLayoutConstraint: NSLayoutConstraint!
    @IBOutlet weak var typesWidthLayoutConstraint: NSLayoutConstraint!
    @IBOutlet weak var maxcpWidthLayoutConstraint: NSLayoutConstraint!
    
    var toRemoveView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
    }

    func set(pokemon: [String: Any]) {
        let num = pokemon["num"] as! NSInteger
        pokemonImage.downloadedFrom(url: PGHelper.imageUrlOfPokemon(width: 40, num: num))
        numLabel?.text = String(format: "#%03d", arguments: [num])
        nameLabel?.text = pokemon["name"] as? String
        staminaLabel?.text = String(pokemon["stamina"] as! Int)
        attackLabel?.text = String(pokemon["attack"] as! Int)
        defenseLabel?.text = String(pokemon["defense"] as! Int)
        maxcpLabel?.text = String(pokemon["maxcp"] as! Int)
        let types = pokemon["types"] as! [String]
        type1Button?.set(types[0])
        if types.count > 1 {
            type2Button?.set(types[1])
            type2Button?.isHidden = false
        }
        else {
            type2Button?.isHidden = true
        }
   
    }
    

}
