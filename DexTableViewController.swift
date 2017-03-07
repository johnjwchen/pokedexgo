//
//  PokemonDexTableViewController.swift
//  PokedexGo
//
//  Created by JIAWEI CHEN on 3/2/17.
//  Copyright © 2017 PokGear. All rights reserved.
//

import UIKit

protocol ShowSortTableDelegate {
    func showTable(sortKey: String, up: Bool, scope: Int)
}

enum DexType {
    case Pokemon
    case Move
}

class DexTableViewController: UITableViewController {
    
    var showSortDelegate: ShowSortTableDelegate?
    
    
    private var dexType: DexType = .Pokemon
    private var dexKey: String = ""
    
    func setDex(dexType: DexType, dexKey: String) {
        self.dexKey = dexKey
        self.dexType = dexType
    }
    
    private var layout: [Any]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        layout = PGJSON.layout!["pokemon"] as! [Any]
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 140
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return layout.count
    }
    

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let sec = layout[section] as! [String: Any]
        if let key = sec["key"] as? String {
            return 2
        }
        else {
            return 1;
        }
    }
    
    func cellIdentifier(section: Int) -> String! {
        let sec = layout[section] as! [String: Any]
        return sec["cell"] as! String
    }

    func configPokemon(cell: UITableViewCell!, indexPath: IndexPath) {
       
        let pokemon = PGJSON.pokeDex?[dexKey] as! [String: Any]
        
        if let nameCell = cell as? NameTableViewCell{
            nameCell.set(info: pokemon)
            
        }
        else if let imageCell = cell as? ImageTableViewCell {
            imageCell.setPokemonImage(num: Int(dexKey)!)
        }
        else if let typeCell = cell as? TypeTableViewCell {
            typeCell.set(types: pokemon["types"] as! [String])
        }
        else if let statsCell = cell as? StatsTableViewCell {
            statsCell.set(stats: pokemon)
        }
        else if let titleCell = cell as? TitleTableViewCell {
            let sec = layout[indexPath.section] as! [String: Any]
            titleCell.setTitle(name: sec["title"] as! String)
        }
        else if let moveCell = cell as? MoveTableViewCell {
            /// moves
            let dict = layout[indexPath.section] as! [String: Any]
            let key = dict["key"] as! String
            let array = pokemon[key]as! [AnyObject]
            let moveName = array[indexPath.row] as! String
            let move = PGJSON.moveOf(name: moveName)
            moveCell.set(move: move)
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let identifier = cellIdentifier(section: indexPath.section)
        let cell = tableView.dequeueReusableCell(withIdentifier: identifier!, for: indexPath)

        configPokemon(cell: cell, indexPath: indexPath)

        return cell
    }
   
    @IBAction func powerTouchUp(_ sender: Any) {
        showSortDelegate?.showTable(sortKey: "power", up: false, scope: 2)
    }
    @IBAction func cdTouchUp(_ sender: Any) {
        showSortDelegate?.showTable(sortKey: "cd", up: false, scope: 2)
    }
    @IBAction func dpsTouchUp(_ sender: Any) {
        showSortDelegate?.showTable(sortKey: "dps", up: false, scope: 2)
    }
    @IBAction func epsTouchUp(_ sender: Any) {
        showSortDelegate?.showTable(sortKey: "eps", up: false, scope: 2)
    }

    @IBAction func staminaTouchUp(_ sender: Any) {
        showSortDelegate?.showTable(sortKey: "stamina", up: false, scope: 1)
    }
    @IBAction func attackTouchUp(_ sender: Any) {
        showSortDelegate?.showTable(sortKey: "attack", up: false, scope: 1)
    }
    @IBAction func defenseTouchUp(_ sender: Any) {
        showSortDelegate?.showTable(sortKey: "defense", up: false, scope: 1)
    }
    @IBAction func maxcpTouchUp(_ sender: Any) {
        showSortDelegate?.showTable(sortKey: "maxcp", up: false, scope: 1)
    }
    

}
