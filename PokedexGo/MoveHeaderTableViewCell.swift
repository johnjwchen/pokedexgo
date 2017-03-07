//
//  MoveHeaderTableViewCell.swift
//  PokedexGo
//
//  Created by JIAWEI CHEN on 3/6/17.
//  Copyright © 2017 PokGear. All rights reserved.
//

import UIKit

protocol MoveSortDelegate {
    func sortMove(key: String, up: Bool);
}

class MoveHeaderTableViewCell: UITableViewCell {
    
    @IBOutlet weak var typeView: UIView!
    @IBOutlet weak var nameView: UIView!
    @IBOutlet weak var powerView: UIView!
    @IBOutlet weak var dpsView: UIView!
    @IBOutlet weak var cdView: UIView!
    @IBOutlet weak var espView: UIView!

    @IBOutlet weak var typeLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var powerLabel: UILabel!
    @IBOutlet weak var cdLabel: UILabel!
    @IBOutlet weak var dpsLabel: UILabel!
    @IBOutlet weak var espLabel: UILabel!
    
    var toRemoveView: UIView!
    
    fileprivate(set) var sortKey: String! = "name"
    
    /// fase: sort up 1, 2, 3...
    /// true: sort down 9, 8, 7...
    fileprivate(set) var sortUp: Bool = true
    
    func setSort(key: String!, up: Bool) {
        sortKey = key
        sortUp = up
        updateArrow()
    }
    
    private lazy var labelArray: [UILabel?] = {
        return [
            self.typeLabel,
            self.nameLabel,
            self.powerLabel,
            self.cdLabel,
            self.dpsLabel,
            self.espLabel
        ]
    }()
    
    func updateArrow() {
        for label in labelArray {
            label?.text = label?.text?.replacingOccurrences(of: "▲", with: "").replacingOccurrences(of: "▼", with: "")
        }
        
        let arrow = sortUp ? "▲" : "▼" 
        switch sortKey {
        case "type":
            typeLabel.text = typeLabel.text! + arrow
        case "name":
            nameLabel.text = nameLabel.text! + arrow
        case "power":
            powerLabel.text = powerLabel.text! + arrow
        case "cd":
            cdLabel.text = cdLabel.text! + arrow
        case "dps":
            dpsLabel.text = dpsLabel.text! + arrow
        case "esp":
            espLabel.text = espLabel.text! + arrow
        default: break
        }
    }
    
    var delegate: MoveSortDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        if UIDevice.current.userInterfaceIdiom != .pad {
            espView.removeFromSuperview()
        }
        
        // tap gesture
        let typetap = UITapGestureRecognizer(target: self, action: #selector(self.typeTap(_:)))
        typeView?.addGestureRecognizer(typetap)
        
        let nametap = UITapGestureRecognizer(target: self, action: #selector(self.nameTap(_:)))
        nameView?.addGestureRecognizer(nametap)
        
        let powertap = UITapGestureRecognizer(target: self, action: #selector(self.powerTap(_:)))
        powerView?.addGestureRecognizer(powertap)
        
        let cdtap = UITapGestureRecognizer(target: self, action: #selector(self.cdTap(_:)))
        cdView?.addGestureRecognizer(cdtap)
        
        let dpstap = UITapGestureRecognizer(target: self, action: #selector(self.dpsTap(_:)))
        dpsView?.addGestureRecognizer(dpstap)
        
        let esptap = UITapGestureRecognizer(target: self, action: #selector(self.espTap(_:)))
        espView?.addGestureRecognizer(esptap)
    }
    
    func tap(key: String?) {
        if (key == sortKey) {
            sortUp = !sortUp
        }
        else {
            sortUp = false
            sortKey = key!
        }
        updateArrow()
        delegate?.sortMove(key: sortKey, up: sortUp)
    }
    
    
    
    func typeTap(_ sender: UITapGestureRecognizer) {
        tap(key: "type")
    }
    
    func nameTap(_ sender: UITapGestureRecognizer) {
        tap(key: "name")
    }
    
    func powerTap(_ sender: UITapGestureRecognizer) {
        tap(key: "power")
    }
    
    func cdTap(_ sender: UITapGestureRecognizer) {
        tap(key: "cd")
    }
    
    func dpsTap(_ sender: UITapGestureRecognizer) {
        tap(key: "dps")
    }
    
    func espTap(_ sender: UITapGestureRecognizer) {
        tap(key: "eps")
    }

}
