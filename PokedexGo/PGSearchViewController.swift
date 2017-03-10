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
 
    fileprivate(set) var pokemonArray: [Any]!
    fileprivate(set) var moveArray: [Any]!
    
    fileprivate lazy var pokemonMutableArray: [Any] = {
        return Array(PGJSON.pokeDex.values)
    }()
    fileprivate lazy var moveMutableArray: [Any] = {
        return Array(PGJSON.moveDex.values)
    }()
    
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
        
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        self.tableView.reloadData()
    }
    
    
    func setUpArrays() {
        if segmentIndex > -1 {
            segmentedControl.selectedSegmentIndex = segmentIndex
            // search
            searchBar.text = searchKey
            searchTable()
            if segmentIndex == 1 {
                pokemonHeaderView.setSort(key: sortKey, up: sortUp)
            }
            if segmentIndex == 2 {
                moveHeaderView.setSort(key: sortKey, up: sortUp)
            }
        }
        
        segmentIndex = -1
        sortKey = nil
        searchKey = nil
        
        searchSortTable()
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
    
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        setUpArrays()
    }

}

extension PGSearchViewController: PokemonSortDelegate, MoveSortDelegate {
    
    fileprivate func searchTable() {
        // search
        pokemonArray = search(array: pokemonMutableArray, key: searchBar.text)
        moveArray = search(array: moveMutableArray, key: searchBar.text)
    }
    func searchSortTable() {
        searchTable()
        
        // sort
        sortPokemon(key: pokemonHeaderView.sortKey, up: pokemonHeaderView.sortUp)
        sortMove(key: moveHeaderView.sortKey, up: moveHeaderView.sortUp)
    }
    
    private func search(array: [Any], key: String?) -> [Any] {
        if key == nil || (key?.characters.count)! < 1 {
            return array
        }
        let mykey = key!.lowercased()
        var arr = Array<Any>()
        for item in array {
            let dict = item as! [String: Any]
            // name
            if let name = dict["name"] as? String, name.lowercased().range(of: mykey) != nil {
                arr.append(dict)
            }
            // type
            else if let type = dict["type"] as? String, type.lowercased() == mykey{
                arr.append(dict)
            }
            else if let types = dict["types"] as? [AnyObject] {
                for itm in types {
                    let type = itm as! String
                    if type.lowercased() == mykey {
                        arr.append(dict)
                        continue
                    }
                }
            }
//            if let category = dict["category"] as? String, category.lowercased() == mykey {
//                arr.add(dict)
//            }
        }
        
        return arr
    }
    
    func sortPokemon(key: String, up: Bool) {
        var sortArray = Array(self.pokemonArray)
        DispatchQueue.global(qos: .default).async {
            sortArray.sort(by: { (a, b) -> Bool in
                return PGSearchViewController.mysort(a: a, b: b, key: key, up: up)
            })
            DispatchQueue.main.async {
                self.pokemonArray = sortArray
                self.tableView.reloadData()
            }
        }
    }
    
    func comparisonResult(value: Bool) -> ComparisonResult {
        if value {
            return .orderedAscending
        }
        else {
            return .orderedDescending
        }
    }
    
    open class func mysort(a: Any, b: Any, key: String, up: Bool) -> Bool {
        let move1 = a as! [String: AnyObject]
        let move2 = b as! [String: AnyObject]
        if let s1 = move1[key] as? String, let s2 = move2[key] as? String {
            return !up ? s1 > s2 : s1 < s2
        }
        else if let d1 = move1[key] as? Double, let d2 = move2[key] as? Double {
            return !up ? d1 > d2 : d1 < d2
        }
        else if let f1 = move1[key] as? Float, let f2 = move2[key] as? Float {
            return !up ? f1 > f2 : f1 < f2
        }
        else if let v1 = move1[key] as? Int, let v2 = move2[key] as? Int {
            return !up ? v1 > v2 : v1 < v2
        }
        else {
            return false
        }
    }
    
    func doSort(a: Any, b: Any, key: String, up: Bool) -> ComparisonResult {
        return comparisonResult(value: PGSearchViewController.mysort(a: a, b: b, key: key, up: up))
    }
    
    func sortMove(key: String, up: Bool) {
        var sortArray = Array(self.moveArray)
        DispatchQueue.global(qos: .default).async {
            sortArray.sort(by: { (a, b) -> Bool in
                return PGSearchViewController.mysort(a: a, b: b, key: key, up: up)
            })
            DispatchQueue.main.async {
                self.moveArray = sortArray
                self.tableView.reloadData()
            }
        }
    }
}

extension PGSearchViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        searchSortTable()
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
            let pokemon = pokemonArray[indexPath.row] as! [String : Any]
            
            viewPage(type: .Pokemon, key: String(pokemon["num"] as! Int))
        }
        else {
            let move = moveArray[indexPath.row] as! [String : Any]
            viewPage(type: .Move, key: PGHelper.keyString(moveName: move["name"] as! String))
        }
    }
    
}
