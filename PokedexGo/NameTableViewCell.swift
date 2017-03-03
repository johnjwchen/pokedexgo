//
//  NameTableViewCell.swift
//  PokedexGo
//
//  Created by JIAWEI CHEN on 3/3/17.
//  Copyright © 2017 PokGear. All rights reserved.
//

import UIKit

class NameTableViewCell: UITableViewCell {

    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var detail: UILabel!
    @IBOutlet weak var gender: UILabel!
    @IBOutlet weak var category: UIButton!
    
    func setInfo(info: NSDictionary) {
        /// to do
    }
}
