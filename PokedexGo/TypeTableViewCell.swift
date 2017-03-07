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
 
    
    func set(types: [String]) {
        if types.count > 0 {
            type1Button.set(types[0])
        }
        if types.count > 1 {
            type2Button.set(types[1])
        }
    }

  

}
