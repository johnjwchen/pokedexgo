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
    
    lazy var searchViewController: UISearchController! = {
        return UISearchController(searchResultsController: nil)
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = self
        tableView.delegate = self
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 140
        
        segmentedControl.removeAllSegments()
        segmentedControl.insertSegment(withTitle: "All", at: 0, animated: false)
        segmentedControl.insertSegment(withTitle: "Pokemon", at: 1, animated: false)
        segmentedControl.insertSegment(withTitle: "Move", at: 2, animated: false)
        
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

extension PGSearchViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 13
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if (indexPath.section == 0) {
            let cell = tableView.dequeueReusableCell(withIdentifier: "PokemonCell", for: indexPath) as! PokemonTableViewCell
            
            // configure the cell
            cell.set(pokemon: ["name": "fuck"])
            
            return cell
        }
        else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "MoveSimpleCell") as! MoveSimpleTableViewCell
            
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 23
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if section == 0 {
            return tableView.dequeueReusableCell(withIdentifier: "PokemonTitleCell")
        }
        else {
            return tableView.dequeueReusableCell(withIdentifier: "MoveTitleCell")
        }
    }
    
}



extension PGSearchViewController: UITableViewDelegate {
    
}
