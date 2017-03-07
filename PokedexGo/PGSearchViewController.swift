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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = self
        tableView.delegate = self
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 140
     
        
        setUpArrays()
    }
    
    func setUpArrays() {
        pokemonArray = Array(PGJSON.pokeDex!.values)
        moveArray = Array(PGJSON.moveDex!.values)
        
        preSortTable()
    }
    
    @IBAction func segmentChanged(_ sender: Any) {
        tableView.reloadData()
    }
    
    
    @IBAction func cancelTouchUp(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    func goSearch() {
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
//        searchBar.becomeFirstResponder()
    }

}

extension PGSearchViewController: PokemonSortDelegate, MoveSortDelegate {
    
    func preSortTable() {
        sortPokemon(key: pokemonHeaderView.sortKey, down: pokemonHeaderView.sortDown)
        sortMove(key: moveHeaderView.sortKey, down: moveHeaderView.sortDown)
    }
    
    func sortPokemon(key: String, down: Bool) {
        pokemonArray.sort { (a, b) -> Bool in
            doSort(a: a, b: b, key: key, down: down)
        }
        tableView.reloadData()
    }
  
    
    func doSort(a: Any, b: Any, key: String, down: Bool) -> Bool {
        let move1 = a as! [String: AnyObject]
        let move2 = b as! [String: AnyObject]
        if let s1 = move1[key] as? String, let s2 = move2[key] as? String {
            return down ? s1 > s2 : s1 < s2
        }
        else if let v1 = move1[key] as? Int, let v2 = move2[key] as? Int {
            return down ? v1 > v2 : v1 < v2
        }
        else {
            return false
        }
    }
    
    func sortMove(key: String, down: Bool) {
        moveArray.sort { (a, b) -> Bool in
            doSort(a: a, b: b, key: key, down: down)
        }
        tableView.reloadData()
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
        return 29
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if segmentedControl.selectedSegmentIndex == 0 && section == 0 ||
            segmentedControl.selectedSegmentIndex == 1 {
            return pokemonHeaderView
        }
        else {
            return moveHeaderView
        }
    }
    
}



extension PGSearchViewController: UITableViewDelegate {
    
}
