//
//  PokemonDexTableViewController.swift
//  PokedexGo
//
//  Created by JIAWEI CHEN on 3/2/17.
//  Copyright © 2017 PokGear. All rights reserved.
//

import UIKit

enum DexType {
    case Pokemon
    case Move
}

class DexTableViewController: UITableViewController {
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

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let identifier = cellIdentifier(section: indexPath.section)
        let cell = tableView.dequeueReusableCell(withIdentifier: identifier!, for: indexPath)

        // Configure the cell...
        if let nameCell = cell as? NameTableViewCell{
            //nameCell?.setInfo(nil)
            
        }
        else if let imageCell = cell as? ImageTableViewCell {
            imageCell.setPokemonImage(num: Int(dexKey)!)
        }
        else if let typeCell = cell as? TypeTableViewCell {
            typeCell.setTypes(type1: PokemonTypeBug, type2: PokemonTypeDark)
        }
        else if let statsCell = cell as? StatsTableViewCell {
            // stats
            //statsCell?.setStats(stats: nil)
        }
        else if let titleCell = cell as? TitleTableViewCell {
            let sec = layout[indexPath.section] as! [String: Any]
            titleCell.setTitle(name: sec["title"] as! String)
        }
        else if let moveCell = cell as? MoveTableViewCell {
            /// moves
        }

        return cell
    }
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
