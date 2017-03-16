//
//  EvolutionTableViewCell.swift
//  PokedexGo
//
//  Created by JIAWEI CHEN on 3/10/17.
//  Copyright © 2017 PokGear. All rights reserved.
//

import UIKit

class EvolutionTableViewCell: UITableViewCell {

    @IBOutlet weak var imageButton1: UIButton!
    @IBOutlet weak var imageButton2: UIButton!
    @IBOutlet weak var imageButton3: UIButton!
    
    @IBOutlet weak var arrowView1: UIView!
    @IBOutlet weak var arrowView2: UIView!
    
    @IBOutlet weak var stackView: UIStackView!
    
    @IBOutlet weak var arrowLabel1: PGArrowLabel!
    @IBOutlet weak var arrowLabel2: PGArrowLabel!
    
    private lazy var imageButtons: [UIButton] = {
        return [
            self.imageButton1,
            self.imageButton2,
            self.imageButton3
        ]
    }()
    
    private lazy var arrowViews: [UIView] = {
        return [
            self.arrowView1,
            self.arrowView2
        ]
    }()
    
    private lazy var arrowLabels: [UILabel] = {
        return [
            self.arrowLabel1,
            self.arrowLabel2
        ]
    }()
    
    var viewPageDelegate: ViewDexPageDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        for button in self.imageButtons {
            button.addTarget(self, action: #selector(imageButtonTouchUp(_:)), for: .touchUpInside)
        }
    }
    
    func imageButtonTouchUp(_ sender: Any) {
        let button = sender as! UIButton
        viewPageDelegate?.viewPage(type: .Pokemon, key: String(button.tag))
    }

    
    func set(evolution: [String: Any]) {
        self._set(evolution: evolution, i: 0)
    }
    
    private func _set(evolution: [String: Any], i: Int) {
        let from = evolution["from"] as! Int
        let pokemon = PGJSON.pokeDex[String(from)] as! [String: Any]
        self.imageButtons[i].downloadedFrom(url: PGHelper.imageUrlOfPokemon(width: 60, num: pokemon["num"] as! Int), placeTitle: pokemon["name"] as! String)
        self.imageButtons[i].tag = from
        let candy = evolution["candy"] as! Int
        self.arrowLabels[i].text = String(format: "%d Candy", candy)
        
        if let to = evolution["to"] as? Int {
            let toPokemon = PGJSON.pokeDex[String(to)] as! [String: Any]
            self.imageButtons[i + 1].downloadedFrom(url: PGHelper.imageUrlOfPokemon(width: 60, num: to), placeTitle: toPokemon["name"] as! String)
            self.imageButtons[i + 1].tag = to
            if i == 0 {
                self.imageButtons[2].removeFromSuperview()
                self.arrowViews[1].removeFromSuperview()
            }
        }
        else if let to = evolution["to"] as? [String: Any] {
            self._set(evolution: to, i: i + 1)
        }
        else if let to = evolution["to"] as? [Any] {
            if i + 1 < self.arrowViews.count {
                self.arrowViews[i + 1].removeFromSuperview()
            }
            var k = 0
            while (k + i + 1 < self.imageButtons.count && k < to.count) {
                let num = to[k] as! Int
                self.imageButtons[k + i + 1].tag = num
                let pkm = PGJSON.pokeDex[String(num)] as! [String: Any]
                self.imageButtons[k + i + 1].downloadedFrom(url: PGHelper.imageUrlOfPokemon(width: 60, num: num), placeTitle: pkm["name"] as! String)
                k += 1
            }
            while (k < to.count) {
                let num = to[k] as! Int
                let button = UIButton(type: .system)
                button.widthAnchor.constraint(equalToConstant: 60).isActive = true
                button.tag = num
                button.addTarget(self, action: #selector(imageButtonTouchUp(_:)), for: .touchUpInside)
                let pkm = PGJSON.pokeDex[String(num)] as! [String: Any]
                button.downloadedFrom(url: PGHelper.imageUrlOfPokemon(width: 60, num: num), placeTitle: pkm["name"] as! String)
                self.stackView.addArrangedSubview(button)
                self.stackView.setNeedsLayout()
                k += 1
            }
            while (k + i + 1 < self.imageButtons.count) {
                self.imageButtons[k + i + 1].removeFromSuperview()
                k += 1
            }
        }
    }
}

