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
    
    static let preferredLanguage = NSLocale.preferredLanguages[0] as String
    
    
    func text(genderType: Int) -> String? {
        switch genderType {
        case 1:
            return "♂"
        case 7:
            return "♀"
        case 8:
            return ""
        default:
            return "♂ ♀"
        }
    }
    func set(info: [String: Any]) {
        name.text = info["name"] as? String
        let h1 = info["height1"] as! String
        let h2 = info["height2"] as! String
        let w1 = info["weight1"] as! String
        let w2 = info["weight2"] as! String
        if NameTableViewCell.preferredLanguage == "en" {
            detail.text = String(format: "%@, %@", h1, w1)
        }
        else {
            detail.text = String(format: "%@, %@", h2, w2)
        }
        gender.text = text(genderType: info["gendertype"] as! Int)
        let cat = String(format: "%@ Pokemon", info["category"] as! String)
        category.setTitle(cat, for: .normal)
    }
}
