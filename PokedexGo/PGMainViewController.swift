//
//  PGMainViewController.swift
//  PokedexGo
//
//  Created by JIAWEI CHEN on 3/9/17.
//  Copyright © 2017 PokGear. All rights reserved.
//

import UIKit

class PGMainViewController: UIViewController {
    @IBOutlet weak var stackView: UIStackView!


    private var pageViewController: PGPageViewController!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }

    @IBAction func searchTouchUp(_ sender: Any) {
        pageViewController?.search()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "EmbedPageViewController" {
            pageViewController = segue.destination as! PGPageViewController
        }
    }
    

}
