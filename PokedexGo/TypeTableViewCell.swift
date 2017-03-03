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
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        //test
        type1Button.pokemonType = PokemonTypeNormal
        type2Button.pokemonType = PokemonTypeNormal
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
