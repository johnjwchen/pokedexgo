//
//  PokemonHeaderTableViewCell.swift
//  PokedexGo
//
//  Created by JIAWEI CHEN on 3/6/17.
//  Copyright © 2017 PokGear. All rights reserved.
//

import UIKit


protocol PokemonSortDelegate {
    func sortPokemon(key: String, up: Bool);
}

class PokemonHeaderTableViewCell: UITableViewCell {
    
    @IBOutlet weak var numView: UIView!
    @IBOutlet weak var typesView: UIView!
    @IBOutlet weak var nameView: UIView!
    @IBOutlet weak var staminaView: UIView!
    @IBOutlet weak var attackView: UIView!
    @IBOutlet weak var defenseView: UIView!
    @IBOutlet weak var maxcpView: UIView!
    
    @IBOutlet weak var numLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var staminaLabel: UILabel!
    @IBOutlet weak var attackLabel: UILabel!
    @IBOutlet weak var defenseLabel: UILabel!
    @IBOutlet weak var maxcpLabel: UILabel!
    
    var toRemoveView: UIView!
    
    private(set) var sortKey: String! = "num"
    
    /// fase: sort up 1, 2, 3...
    /// true: sort down 9, 8, 7...
    private(set) var sortUp: Bool = true
    
    func setSort(key: String!, up: Bool) {
        sortKey = key
        sortUp = up
        updateArrow()
    }
    
    private lazy var labelArray: [UILabel?] = {
        return [
            self.numLabel,
            self.nameLabel,
            self.staminaLabel,
            self.attackLabel,
            self.defenseLabel,
            self.maxcpLabel
        ]
        }()
    
    func updateArrow() {
        for label in labelArray {
            label?.text = label?.text?.replacingOccurrences(of: "▲", with: "").replacingOccurrences(of: "▼", with: "")
        }
        
        let arrow = sortUp ? "▲" : "▼"
        switch sortKey {
        case "num":
            numLabel?.text = numLabel.text! + arrow
        case "name":
            nameLabel?.text = nameLabel.text! + arrow
        case "stamina":
            staminaLabel.text = staminaLabel.text! + arrow
        case "attack":
            attackLabel.text = attackLabel.text! + arrow
        case "defense":
            defenseLabel.text = defenseLabel.text! + arrow
        case "maxcp":
            maxcpLabel?.text = maxcpLabel.text! + arrow
        default: break
        }
    }
    
    
    
    var delegate: PokemonSortDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        // tap gesture
        let numtap = UITapGestureRecognizer(target: self, action: #selector(self.numTap(_:)))
        numView!.addGestureRecognizer(numtap)
        
        let nametap = UITapGestureRecognizer(target: self, action: #selector(self.nameTap(_:)))
        nameView!.addGestureRecognizer(nametap)
        
        let staminatap = UITapGestureRecognizer(target: self, action: #selector(self.staminaTap(_:)))
        staminaView!.addGestureRecognizer(staminatap)
        
        let attacktap = UITapGestureRecognizer(target: self, action: #selector(self.attackTap(_:)))
        attackView!.addGestureRecognizer(attacktap)
        
        let defensetap = UITapGestureRecognizer(target: self, action: #selector(self.defenseTap(_:)))
        defenseView!.addGestureRecognizer(defensetap)
        
        let maxcptap = UITapGestureRecognizer(target: self, action: #selector(self.maxcpTap(_:)))
        maxcpView!.addGestureRecognizer(maxcptap)
    }
    
    func tap(key: String?) {
        if (key == sortKey) {
            sortUp = !sortUp
        }
        else {
            sortUp = false
            sortKey = key
        }
        delegate?.sortPokemon(key: sortKey, up: sortUp)
        updateArrow()
    }
    

    func numTap(_ sender: UITapGestureRecognizer) {
        tap(key: "num")
    }
    
    func nameTap(_ sender: UITapGestureRecognizer) {
        tap(key: "name")
    }
    
    func staminaTap(_ sender: UITapGestureRecognizer) {
        tap(key: "stamina")
    }
    
    func attackTap(_ sender: UITapGestureRecognizer) {
        tap(key: "attack")
    }
    
    func defenseTap(_ sender: UITapGestureRecognizer) {
        tap(key: "defense")
    }
    
    func maxcpTap(_ sender: UITapGestureRecognizer) {
        tap(key: "maxcp")
    }
    
    static func initSortedArray() {
        PGJSON.sortedPokemon(key: "num")
        PGJSON.sortedPokemon(key: "name")
        PGJSON.sortedPokemon(key: "stamina")
        PGJSON.sortedPokemon(key: "attack")
        PGJSON.sortedPokemon(key: "defense")
        PGJSON.sortedPokemon(key: "maxcp")
    }

}
