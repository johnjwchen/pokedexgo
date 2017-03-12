//
//  TypeEffectView.swift
//  PokedexGo
//
//  Created by JIAWEI CHEN on 3/11/17.
//  Copyright © 2017 PokGear. All rights reserved.
//

import UIKit

class TypeEffectView: UIView {

    @IBOutlet weak var typeButton: PTTypeButton!
    @IBOutlet weak var effectLabel: UILabel!
    
    class func instanceFromNib() -> TypeEffectView {
        return UINib(nibName: "TypeEffectView", bundle: nil).instantiate(withOwner: nil, options: nil)[0] as! TypeEffectView
    }
    
    func set(effect: Float) {
        if effect > 1 {
            effectLabel.text = String(format: "%dx", Int(effect))
        }
        else if effect == 0 {
            effectLabel.text = "0"
        }
        else {
            if effect == 0.5 {
                effectLabel.text = "½x"
            }
            else if effect == 0.25 {
                effectLabel.text = "¼x"
            }
            else if effect == 0.125 {
                effectLabel.text = "⅛x"
            }
        }
    }
    
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
