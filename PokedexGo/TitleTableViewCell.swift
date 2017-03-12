//
//  TitleTableViewCell.swift
//  PokedexGo
//
//  Created by JIAWEI CHEN on 3/3/17.
//  Copyright © 2017 PokGear. All rights reserved.
//

import UIKit

class TitleTableViewCell: UITableViewCell {

    @IBOutlet weak var title: UILabel!

    func setTitle(name: String) {
        title.text = name
    }
}
