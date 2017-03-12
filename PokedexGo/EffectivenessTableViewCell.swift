//
//  EffectivenessTableViewCell.swift
//  PokedexGo
//
//  Created by JIAWEI CHEN on 3/11/17.
//  Copyright © 2017 PokGear. All rights reserved.
//

import UIKit

class EffectivenessTableViewCell: UITableViewCell {
    @IBOutlet weak var superEffectStackView: UIStackView!
    @IBOutlet weak var lessEffectStackView: UIStackView!

    private var _delegate: PTTypeButtonDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    private func addArray(_ array: [Any], to stackView: UIStackView) {
        for item in array {
            let ar = item as! [Any]
            let view = TypeEffectView.instanceFromNib()
            view.typeButton.pokemonType = PokemonType(rawValue: UInt32(ar[0] as! Int))
            view.set(effect: ar[1] as! Float)
            stackView.addArrangedSubview(view)
        }
    }

    func set(typeNames:[String]!, delegate: PTTypeButtonDelegate) {
        if _delegate != delegate as! _OptionalNilComparisonType {
            return
        }
        _delegate = delegate
        
        let effect = PGHelper.effectOn(typeNames: typeNames)
    
        addArray(effect["super"] as! [Any], to: superEffectStackView)
        addArray(effect["less"] as! [Any], to: lessEffectStackView)
    }

}
