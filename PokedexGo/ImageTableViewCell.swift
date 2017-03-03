//
//  ImageTableViewCell.swift
//  PokedexGo
//
//  Created by JIAWEI CHEN on 3/3/17.
//  Copyright © 2017 PokGear. All rights reserved.
//

import UIKit

class ImageTableViewCell: UITableViewCell {

    @IBOutlet weak var centralImage: UIImageView!
    
    func setPokemonImage(num: Int) {
        centralImage.downloadedFrom(url: PGHelper.imageUrlOfPokemon(width: 240, num: num))
    }

}
