//
//  PGSearchTableViewController.swift
//  PokedexGo
//
//  Created by JIAWEI CHEN on 3/4/17.
//  Copyright © 2017 PokGear. All rights reserved.
//

import UIKit



class PGSearchViewController: UIViewController {
    
    var viewPageDelegate: ViewDexPageDelegate?
    
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
 
    fileprivate(set) var pokemonArray: [String]!
    fileprivate(set) var moveArray: [String]!
    
    
    fileprivate var isSearching: Bool = false
    
    var segmentIndex: Int = -1
    var sortKey: String?
    var sortUp: Bool!
    var searchKey: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = self
        tableView.delegate = self
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 140
        
        searchBar.delegate = self
        
        setUpArrays()
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        self.tableView.reloadData()
    }
    
    
    func setUpArrays() {
        guard segmentedControl != nil else {
            return
        }
        if searchBar.text != searchKey {
            searchBar.text = searchKey
        }
        if segmentIndex > -1 {
            segmentedControl.selectedSegmentIndex = segmentIndex
        }
        
      
        if sortKey != nil && segmentIndex == 1 && pokemonHeaderView.sortKey != sortKey {
            pokemonHeaderView.setSort(key: sortKey, up: sortUp)
        }
        if sortKey != nil && segmentIndex == 2 && moveHeaderView.sortKey != sortKey {
            moveHeaderView.setSort(key: sortKey, up: sortUp)
        }
        
        sortKey = nil
        segmentIndex = -1
        searchKey = nil
        
        searchTable()
    }
    
    
    
    @IBAction func segmentChanged(_ sender: Any) {
        tableView.reloadData()
    }
    
    
    @IBAction func cancelTouchUp(_ sender: Any) {
        if isSearching {
            //isSearching = false
            searchBar.resignFirstResponder()
            return
        }
        self.dismiss(animated: true, completion: nil)
    }
    
    fileprivate func moveAt(row: Int) -> [String : Any] {
        let up = moveHeaderView.sortUp
        let name = moveArray[up ? (moveArray.count - row - 1) : row]
        return PGJSON.moveDex[name] as! [String : Any]
    }
    
    fileprivate func pokemonAt(row: Int) -> [String: Any] {
        let up = pokemonHeaderView.sortUp
        let name = pokemonArray[up ? (pokemonArray.count - row - 1) : row]
        return PGJSON.pokeDex[name] as! [String : Any]
    }
    
    
    
//    override func viewWillAppear(_ animated: Bool) {
//        super.viewWillAppear(animated)
//        
//        setUpArrays()
//    }

}

extension PGSearchViewController: PokemonSortDelegate, MoveSortDelegate {
    
    fileprivate func searchTable() {
        // search
        let sortedPokemon = PGJSON.sortedPokemon(key: pokemonHeaderView.sortKey)
        pokemonArray = search(array: sortedPokemon, key: searchBar.text, dex: PGJSON.pokeDex)
        let sortedMove = PGJSON.sortedMove(key: moveHeaderView.sortKey)
        moveArray = search(array: sortedMove, key: searchBar.text, dex: PGJSON.moveDex)
        
        self.tableView.reloadData()
    }
   
    
    private func search(array: [String], key: String?, dex: [String: Any]) -> [String] {
        if key == nil || (key?.characters.count)! < 1 {
            return array
        }
        let mykey = key!.lowercased()
        let keyIsType = PGHelper.typeNameDict.keys.contains(mykey)
        var arr = Array<String>()
        for item in array {
            let dict = dex[item] as! [String: Any]
            // name
            if let types = dict["types"] as? [AnyObject] {
                for itm in types {
                    let type = itm as! String
                    if type.lowercased() == mykey {
                        arr.append(item)
                        break
                    }
                }
            }
            else if let type = dict["type"] as? String, type.lowercased() == mykey{
                arr.append(item)
            }
            else if keyIsType {
                // only search type(s)
                continue
            }
            else if let name = dict["name"] as? String, name.lowercased().range(of: mykey) != nil {
                arr.append(item)
            }
            
//            if let category = dict["category"] as? String, category.lowercased() == mykey {
//                arr.add(dict)
//            }
        }
        
        return arr
    }
    
    func sortPokemon(key: String, up: Bool) {
        searchTable()
    }
    
    
    func sortMove(key: String, up: Bool) {
        searchTable()
    }
}

extension PGSearchViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        searchTable()
    }
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        isSearching = true
    }
    
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        isSearching = false
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
            cell.set(pokemon: pokemonAt(row: indexPath.row))
            
            return cell
        }
        else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "MoveSimpleCell") as! MoveSimpleTableViewCell
            cell.set(move: moveAt(row: indexPath.row))
            
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        let headerHeight: CGFloat = 33
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
    func viewPage(type: DexType, key: String!) {
//        self.dismiss(animated: true) {
//            self.viewPageDelegate?.viewPage(type: type, key: key)
//        }
        
        let transition: CATransition = CATransition()
        transition.duration = 0.5
        transition.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)
        transition.type = kCATransitionReveal
        transition.subtype = kCATransitionFromRight
        self.view.window!.layer.add(transition, forKey: nil)
        self.dismiss(animated: false, completion: nil)
        self.viewPageDelegate?.viewPage(type: type, key: key)
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if (segmentedControl.selectedSegmentIndex == 0 && indexPath.section == 0 ||
            segmentedControl.selectedSegmentIndex == 1) {
            let pokemon = pokemonAt(row: indexPath.row)
            
            viewPage(type: .Pokemon, key: String(pokemon["num"] as! Int))
        }
        else {
            
            let move = moveAt(row: indexPath.row)
            viewPage(type: .Move, key: PGHelper.keyString(moveName: move["name"] as! String))
        }
    }
    
}
