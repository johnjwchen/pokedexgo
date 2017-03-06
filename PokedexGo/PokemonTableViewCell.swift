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
    @IBOutlet weak var weightLabel: UILabel!
    @IBOutlet weak var heightLabel: UILabel!
    @IBOutlet weak var categoryLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        if UIDevice.current.userInterfaceIdiom != .pad {
            categoryLabel.removeFromSuperview()
        }
    }

    func set(pokemon: [String: Any]) {
        pokemonImage.downloadedFrom(url: PGHelper.imageUrlOfPokemon(width: 60, num: 11))
    }
    

}
