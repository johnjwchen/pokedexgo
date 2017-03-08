//
//  PGSearchTableViewController.swift
//  PokedexGo
//
//  Created by JIAWEI CHEN on 3/4/17.
//  Copyright © 2017 PokGear. All rights reserved.
//

import UIKit



class PGSearchViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    
    fileprivate lazy var pokemonHeaderView: PokemonHeaderTableViewCell = {
        let header = self.tableView.dequeueReusableCell(withIdentifier: "PokemonTitleCell") as! PokemonHeaderTableViewCell
        header.delegate = self
        return header
    }()
    
    fileprivate lazy var moveHeaderView: MoveHeaderTableViewCell = {
        let header = self.tableView.dequeueReusableCell(withIdentifier: "MoveTitleCell") as! MoveHeaderTableViewCell
        header.delegate = self
        return header
    }()
    
    lazy var searchViewController: UISearchController! = {
        return UISearchController(searchResultsController: nil)
    }()
 
    fileprivate(set) var pokemonArray: [Any]!
    fileprivate(set) var moveArray: [Any]!
    
    
    var segmentIndex: Int = -1
    
    var sortKey: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = self
        tableView.delegate = self
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 140
        
        searchBar.delegate = self
    }
    
    
    
    func setUpArrays() {
        if segmentIndex > -1 {
            segmentedControl.selectedSegmentIndex = segmentIndex
            if segmentIndex == 1 {
                pokemonHeaderView.setSort(key: sortKey, up: false)
            }
            if segmentIndex == 2 {
                moveHeaderView.setSort(key: sortKey, up: false)
            }
        }
        
        segmentIndex = -1
        sortKey = nil
        
        searchSortTable()
    }
    
    
    
    @IBAction func segmentChanged(_ sender: Any) {
        tableView.reloadData()
    }
    
    
    @IBAction func cancelTouchUp(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        setUpArrays()
    }

}

extension PGSearchViewController: PokemonSortDelegate, MoveSortDelegate {
    
    func searchSortTable() {
        // search
        pokemonArray = search(array: Array(PGJSON.pokeDex.values), key: searchBar.text)
        moveArray = search(array: Array(PGJSON.moveDex.values), key: searchBar.text)
        
        // sort
        sortPokemon(key: pokemonHeaderView.sortKey, up: pokemonHeaderView.sortUp)
        sortMove(key: moveHeaderView.sortKey, up: moveHeaderView.sortUp)
    }
    
    private func search(array: Array<Any>, key: String?) -> Array<Any> {
        if key == nil || (key?.characters.count)! < 1 {
            return array
        }
        let mykey = key!.lowercased()
        var arr = Array<Any>()
        for item in array {
            let dict = item as! [String: Any]
            // name
            if let name = dict["name"] as? String, name.lowercased().range(of: mykey) != nil {
                arr.append(item)
            }
            // type
            else if let type = dict["type"] as? String, type.lowercased() == mykey{
                arr.append(item)
            }
            else if let types = dict["types"] as? [AnyObject] {
                for itm in types {
                    let type = itm as! String
                    if type.lowercased() == mykey {
                        arr.append(item)
                        continue
                    }
                }
            }
            if let category = dict["category"] as? String, category.lowercased() == mykey {
                arr.append(category)
            }
        }
        
        return arr
    }
    
    func sortPokemon(key: String, up: Bool) {
        pokemonArray.sort { (a, b) -> Bool in
            doSort(a: a, b: b, key: key, up: up)
        }
        tableView.reloadData()
    }
  
    
    func doSort(a: Any, b: Any, key: String, up: Bool) -> Bool {
        let move1 = a as! [String: AnyObject]
        let move2 = b as! [String: AnyObject]
        if let s1 = move1[key] as? String, let s2 = move2[key] as? String {
            return !up ? s1 > s2 : s1 < s2
        }
        else if let v1 = move1[key] as? Int, let v2 = move2[key] as? Int {
            return !up ? v1 > v2 : v1 < v2
        }
        else if let f1 = move1[key] as? Float, let f2 = move2[key] as? Float {
            return !up ? f1 > f2 : f1 < f2
        }
        else {
            return false
        }
    }
    
    func sortMove(key: String, up: Bool) {
        moveArray.sort { (a, b) -> Bool in
            doSort(a: a, b: b, key: key, up: up)
        }
        tableView.reloadData()
    }
}

extension PGSearchViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        searchSortTable()
    }
}

extension PGSearchViewController: UITableViewDataSource {
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch segmentedControl.selectedSegmentIndex {
        case 0:
            return section == 0 ? pokemonArray.count : moveArray.count
        case 1:
            return pokemonArray.count
        case 2:
            return moveArray.count
        default:
            return 0
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        switch segmentedControl.selectedSegmentIndex {
        case 0:
            return 2
        case 1:
            return 1
        case 2:
            return 1
        default:
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if (segmentedControl.selectedSegmentIndex == 0 && indexPath.section == 0 ||
            segmentedControl.selectedSegmentIndex == 1) {
            let cell = tableView.dequeueReusableCell(withIdentifier: "PokemonCell", for: indexPath) as! PokemonTableViewCell
            
            // configure the cell
            cell.set(pokemon: pokemonArray[indexPath.row] as! [String : Any])
            
            return cell
        }
        else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "MoveSimpleCell") as! MoveSimpleTableViewCell
            
            cell.set(move: moveArray[indexPath.row] as! [String : Any])
            
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        let headerHeight: CGFloat = 29
        if segmentedControl.selectedSegmentIndex == 0 && section == 0 ||
            segmentedControl.selectedSegmentIndex == 1 {
            return pokemonArray.count > 0 ? headerHeight : 0
        }
        else {
            return moveArray.count > 0 ? headerHeight : 0
        }
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if segmentedControl.selectedSegmentIndex == 0 && section == 0 ||
            segmentedControl.selectedSegmentIndex == 1 {
            return pokemonArray.count > 0 ? pokemonHeaderView : nil
        }
        else {
            return moveArray.count > 0 ? moveHeaderView : nil
        }
    }
    
}



extension PGSearchViewController: UITableViewDelegate {
    
}
