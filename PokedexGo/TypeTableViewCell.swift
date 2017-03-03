//
//  TypeTableViewCell.swift
//  PokedexGo
//
//  Created by JIAWEI CHEN on 3/3/17.
//  Copyright © 2017 PokGear. All rights reserved.
//

import UIKit

class TypeTableViewCell: UITableViewCell {
    @IBOutlet weak var type1Button: PTTypeButton!
    @IBOutlet weak var type2Button: PTTypeButton!
 
    
    func setTypes(type1: PokemonType, type2: PokemonType) {
        type1Button.pokemonType = type1
        type2Button.pokemonType = type2
    }

  

}
