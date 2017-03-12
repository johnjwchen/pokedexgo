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
 
    func set(types: [String], delegate: PTTypeButtonDelegate) {
        if types.count > 0 {
            type1Button.set(types[0])
            type1Button.delegate = delegate
        }
        if types.count > 1 {
            type2Button.isHidden = false
            type2Button.set(types[1])
            type2Button.delegate = delegate
        }
        else {
            type2Button.isHidden = true
        }
    }

  

}
