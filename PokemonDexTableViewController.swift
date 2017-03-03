//
//  PokemonDexTableViewController.swift
//  PokedexGo
//
//  Created by JIAWEI CHEN on 3/2/17.
//  Copyright © 2017 PokGear. All rights reserved.
//

import UIKit

class PokemonDexTableViewController: UITableViewController {
    @IBOutlet weak var pokemonImage: UIImageView!

    override func viewDidLoad() {
        super.viewDidLoad()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 10
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.section {
        case 0:
            return 65
        case 1:
            return 240
        case 2:
            return 44
        case 3:
            return 90 // stats
        case 4:
            return 32 // title
        case 5:
            return 65 // moves
        case 6:
            return 32
        case 7:
            return 65 // move
        case 8:
            return 32
        case 9:
            return 65 // move
        default:
            return 0
        }
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return 1 //pokemon name
        case 1:
            return 1 // pokemon image
        case 2:     // type
            return 1
        case 3:     // stats
            return 1
        case 4:     // Title of 'Fast Moves'
            return 1
        case 5:
            return 2 /// should check the pokemon's Fast moves
        case 6:
            return 1 // title - Charge Moves
        case 7:
            return 1 /// should check the pokemon's Charge moves
        case 8:
            return 1 // title - Ideal Moves
        case 9:
            return 2 /// should check the pokemon's Ideal moves
        default:
            return 0
        }
    }
    
    func cellIdentifier(section: Int) -> String! {
        switch section {
        case 0:
            return "NameCell"
        case 1:
            return "ImageCell"
        case 2:
            return "TypeCell"
        case 3:
            return "StatsCell"
        case 4:
            return "TitleCell"
        case 5:
            return "MoveCell"
        case 6:
            return "TitleCell"
        case 7:
            return "MoveCell"
        case 8:
            return "TitleCell"
        case 9:
            return "MoveCell"
        default:
            return nil
        }
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier(section: indexPath.section), for: indexPath)

        // Configure the cell...
        if (indexPath.section == 0) {
            let nameCell = cell as? NameTableViewCell
            //nameCell?.setInfo(nil)
            
        }
        else if (indexPath.section == 1) {
            let imageCell = cell as? ImageTableViewCell
            imageCell?.setPokemonImage(num: 1)
        }
        else if (indexPath.section == 2) {
            let typeCell = cell as? TypeTableViewCell
            // to do
            typeCell?.setTypes(type1: PokemonTypeBug, type2: PokemonTypeDark)
        }
        else if (indexPath.section == 3) {
            // stats
            let statsCell = cell as? StatsTableViewCell
            //statsCell?.setStats(stats: nil)
        }
        else if (indexPath.section == 4) {
            let titleCell = cell as? TitleTableViewCell
            titleCell?.setTitle(name: "Fast Moves")
        }
        else if (indexPath.section == 5) {
            /// fast moves
        }
        else if (indexPath.section == 6) {
            let titleCell = cell as? TitleTableViewCell
            titleCell?.setTitle(name: "Charge Moves")
        }
        else if (indexPath.section == 7) {
            /// charge moves
            
        }
        else if (indexPath.section == 8) {
            let titleCell = cell as? TitleTableViewCell
            titleCell?.setTitle(name: "Ideal Moves")
        }
        else if (indexPath.section == 9) {
            /// Ideal Moves
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
