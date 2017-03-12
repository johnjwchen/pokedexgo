//
//  PokemonDexTableViewController.swift
//  PokedexGo
//
//  Created by JIAWEI CHEN on 3/2/17.
//  Copyright © 2017 PokGear. All rights reserved.
//

import UIKit

protocol ShowSortTableDelegate {
    func showTable(searchKey: String?, sortKey: String, up: Bool, scope: Int)
}

enum DexType {
    case Pokemon
    case Move
}

class DexTableViewController: UITableViewController {
    
    private var _pageIndex: Int = -1
    var pageIndex: Int {
        get {return _pageIndex}
        set(value) {
            if _pageIndex == -1 && value >= 0 {
                _pageIndex = value
            }
        }
    }
    
    
    var showSortDelegate: ShowSortTableDelegate?
    var viewPageDelegate: ViewDexPageDelegate?
    
    private var dexType: DexType = .Pokemon
    private var dexKey: String = ""
    
    func setDex(dexType: DexType, dexKey: String) {
        self.dexKey = dexKey
        self.dexType = dexType
    }
    
    func hasSame(page: [Any]) -> Bool {
        return dexType == page[0] as! DexType && dexKey == page[1] as! String
    }
    
    private func currentDex() -> [String: Any] {
        return self.dexType == .Pokemon ? PGJSON.pokeDex : PGJSON.moveDex
    }
    
    private var layout: [Any]!
    
    fileprivate(set) var pokemonArray: [Any] = []
    fileprivate(set) var pokemonMoveKey: String!
    
    fileprivate lazy var pokemonHeaderView: PokemonHeaderTableViewCell = {
        let header = self.tableView.dequeueReusableCell(withIdentifier: "PokemonTitleCell") as! PokemonHeaderTableViewCell
        header.delegate = self
        return header
    }()
    
    private lazy var moveTypeButtonDelegate: PTTypeButtonDelegate = {
        class Foo: NSObject, PTTypeButtonDelegate {
            var parentViewController: DexTableViewController!
            init(parent: DexTableViewController) {
                parentViewController = parent
            }
            func touchUp(_ button: Any!) {
                guard let label = button as? UILabel else {
                    return
                }
            parentViewController?.showSortDelegate?.showTable(searchKey: label.text, sortKey: "name", up: false, scope: 2)
            }
        }
        return Foo(parent: self)
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        layout = PGJSON.layout[dexType == .Pokemon ? "pokemon" : "move"] as! [Any]
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 140
        
    }

    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        self.tableView.reloadData()
    }
    
    // MARK: - Table view data delegate
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let identifier = cellIdentifier(indexPath: indexPath)
        
        if dexType == .Pokemon {
            guard identifier == "MoveCell" else {
                return
            }
            let pokemon = PGJSON.pokeDex[dexKey] as! [String: Any]
            let dict = layout[indexPath.section] as! [String: Any]
            let key = dict["key"] as! String
            let array = pokemon[key]as! [AnyObject]
            let moveName = array[indexPath.row] as! String
            
            viewPageDelegate?.viewPage(type: .Move, key: PGHelper.keyString(moveName: moveName))
        }
        if dexType == .Move {
            guard identifier == "PokemonCell" else {
                return
            }
            let pokemon = pokemonArray[indexPath.row] as! [String: Any]
            viewPageDelegate?.viewPage(type: .Pokemon, key: String(pokemon["num"] as! Int))
        }
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return layout.count
    }
    

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let sec = layout[section] as! [String: Any]
        if let key = sec["key"] as? String {
            let pokemon = self.currentDex()[dexKey] as! [String: Any]
            let array = pokemon[key] as! [Any]
            return array.count
        }
        if let cell = sec["cell"] as? String {
            if cell == "PokemonCell" {
                let array = PGJSON.pokemonWith(moveKey: dexKey)
                return array != nil ? array!.count : 0
            }
            if cell == "EvolutionCell" {
                let pokemon = PGJSON.pokeDex[dexKey] as! [String: Any]
                let dict = PGJSON.evolutionOf(pokemonName: pokemon["name"] as! String)
                return dict == nil ? 0 : 1
            }
        }
        
        return 1
    }
    
    func cellIdentifier(indexPath: IndexPath) -> String! {
        let sec = layout[indexPath.section] as! [String: Any]
        return sec["cell"] as! String
    }

    func configPokemon(cell: UITableViewCell!, indexPath: IndexPath) {
       
        let pokemon = PGJSON.pokeDex[dexKey] as! [String: Any]
        
        if let nameCell = cell as? NameTableViewCell{
            nameCell.set(info: pokemon)
            
        }
        else if let imageCell = cell as? ImageTableViewCell {
            imageCell.setPokemonImage(num: Int(dexKey)!)
        }
        else if let typeCell = cell as? TypeTableViewCell {
            typeCell.set(types: pokemon["types"] as! [String], delegate: self as PTTypeButtonDelegate)
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
        else if let desCell = cell as? DescriptionTableViewCell {
            let num = pokemon["num"] as! Int
            let desc = PGJSON.pokemonDescArray[num] as! String
            desCell.set(description: desc)
        }
        else if let evoCell = cell as? EvolutionTableViewCell {
            let pokemonName = pokemon["name"] as! String
            evoCell.set(evolution: PGJSON.evolutionOf(pokemonName: pokemonName)!)
            evoCell.viewPageDelegate = self.viewPageDelegate
        }
        else if let effectCell = cell as? EffectivenessTableViewCell {
            effectCell.set(typeNames: pokemon["types"] as! [String], delegate: self.moveTypeButtonDelegate)
        }
    }
    
    func configMove(cell: UITableViewCell, indexPath: IndexPath) {
        let move = PGJSON.moveDex[dexKey] as! [String: Any]
        
        if let nameCell = cell as? MoveNameTableViewCell {
            nameCell.set(info: move, typeButtonDelegate: moveTypeButtonDelegate)
        }
        else if let desCell = cell as? DescriptionTableViewCell {
            desCell.set(description: move["desc"] as! String)
        }
        else if let titleCell = cell as? TitleTableViewCell {
            let sec = layout[indexPath.section] as! [String: Any]
            titleCell.setTitle(name: sec["title"] as! String)
        }
        else if let pokemonCell = cell as? PokemonTableViewCell {
            if pokemonArray.count < 1 || pokemonMoveKey != dexKey {
                pokemonMoveKey = dexKey
                let array = PGJSON.pokemonWith(moveKey: dexKey)
                pokemonArray.removeAll()
                for name in array! {
                    pokemonArray.append(PGJSON.pokeDex[name]!)
                }
            }
            
            pokemonCell.set(pokemon: pokemonArray[indexPath.row] as! [String : Any])
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let identifier = cellIdentifier(indexPath: indexPath)
        let cell = tableView.dequeueReusableCell(withIdentifier: identifier!, for: indexPath)

        if dexType == .Pokemon {
             configPokemon(cell: cell, indexPath: indexPath)
        }
        if dexType == .Move {
            configMove(cell: cell, indexPath: indexPath)
        }

        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        let sec = layout[section] as! [String: Any]
        let header = sec["header"] as? String
        if header != nil {
            return 29
        }
        return 0
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let sec = layout[section] as! [String: Any]
        let header = sec["header"] as? String
        if header == "PokemonTitleCell" {
            return pokemonHeaderView
        }
        return nil
    }
    

   
    @IBAction func powerTouchUp(_ sender: Any) {
        showSortDelegate?.showTable(searchKey: nil, sortKey: "power", up: false, scope: 2)
    }
  
    @IBAction func cdTouchUp(_ sender: Any) {
        showSortDelegate?.showTable(searchKey: nil, sortKey: "cd", up: true, scope: 2)
    }
    @IBAction func dpsTouchUp(_ sender: Any) {
        showSortDelegate?.showTable(searchKey: nil, sortKey: "dps", up: false, scope: 2)
    }
    @IBAction func epsTouchUp(_ sender: Any) {
        showSortDelegate?.showTable(searchKey: nil, sortKey: "eps", up: false, scope: 2)
    }

    @IBAction func staminaTouchUp(_ sender: Any) {
        showSortDelegate?.showTable(searchKey: nil, sortKey: "stamina", up: false, scope: 1)
    }
    @IBAction func attackTouchUp(_ sender: Any) {
        showSortDelegate?.showTable(searchKey: nil, sortKey: "attack", up: false, scope: 1)
    }
    @IBAction func defenseTouchUp(_ sender: Any) {
        showSortDelegate?.showTable(searchKey: nil, sortKey: "defense", up: false, scope: 1)
    }
    @IBAction func maxcpTouchUp(_ sender: Any) {
        showSortDelegate?.showTable(searchKey: nil, sortKey: "maxcp", up: false, scope: 1)
    }
    
    @IBAction func composeTouchUp(_ sender: Any) {
        let opened = UIApplication.shared.openURL(URL(string: "pokgear://test_page/")!)
        if !opened {
            UIApplication.shared.openURL(URL(string: "https://itunes.apple.com/us/app/pokgear-pokemon-creator/id849383046?ls=1&mt=8")!)
        }
    }
    
}

extension DexTableViewController: PTTypeButtonDelegate {
    // this should only be called by pokemon type button
    func touchUp(_ button: Any!) {
        guard let label = button as? UILabel else {
            return
        }
        showSortDelegate?.showTable(searchKey: label.text, sortKey: "name", up: true, scope: 1)
    }
}

extension DexTableViewController: PokemonSortDelegate {
    func sortPokemon(key: String, up: Bool) {
        pokemonArray = pokemonArray.sorted{ (a, b) -> Bool in
            return PGSearchViewController.mysort(a: a, b: b, key: key, up: up)
        }
        tableView.reloadData()
    }
}
