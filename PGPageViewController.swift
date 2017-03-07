//
//  PGPageViewController.swift
//  PokedexGo
//
//  Created by JIAWEI CHEN on 3/4/17.
//  Copyright © 2017 PokGear. All rights reserved.
//

import UIKit

class PGPageViewController: UIPageViewController {

    fileprivate(set) lazy var orderedViewControllers: [UIViewController] = {
        return [self.newTableViewController(dexType: .Pokemon, dexKey: "1"),
                self.newTableViewController(dexType: .Pokemon, dexKey: "101"),
                self.newTableViewController(dexType: .Pokemon, dexKey: "111")]
    }()
    
    
    private func newTableViewController(dexType: DexType, dexKey: String) -> UIViewController {
        let vc = storyboard!.instantiateViewController(withIdentifier: "DexTableViewController") as! DexTableViewController
        vc.setDex(dexType: dexType, dexKey: dexKey)
        vc.showSortDelegate = self
        return vc
    }
    
    lazy var searchViewController: PGSearchViewController! = {
        return self.storyboard!.instantiateViewController(withIdentifier: "SearchViewController") as! PGSearchViewController
    }()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.setNavigationBarHidden(true, animated: false)

        dataSource = self
        if let firstViewController = orderedViewControllers.first {
            setViewControllers([firstViewController],
                               direction: .forward,
                               animated: true,
                               completion: nil)
        }

        
        
        let button = UIButton(type: .infoDark)
        button.frame = CGRect(x: 50, y: 50, width: 30, height: 30)
        self.view.addSubview(button)
        button.addTarget(self, action: #selector(testTouch), for: .touchUpInside)
        
    }
    
    func testTouch(sender: AnyObject) {
        
        self.present(searchViewController, animated: true, completion: nil)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}


extension PGPageViewController:UIPageViewControllerDataSource {
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        guard let viewControllerIndex = orderedViewControllers.index(of: viewController) else {
            return nil
        }
        
        let previousIndex = viewControllerIndex - 1
        
        guard previousIndex >= 0 else {
            return orderedViewControllers.last
        }
        
        guard orderedViewControllers.count > previousIndex else {
            return nil
        }
        
        return orderedViewControllers[previousIndex]
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        guard let viewControllerIndex = orderedViewControllers.index(of: viewController) else {
            return nil
        }
        
        let nextIndex = viewControllerIndex + 1
        let orderedViewControllersCount = orderedViewControllers.count
        
        guard orderedViewControllersCount != nextIndex else {
            return orderedViewControllers.first
        }
        
        guard orderedViewControllersCount > nextIndex else {
            return nil
        }
        
        return orderedViewControllers[nextIndex]
    }
}

extension PGPageViewController: ShowSortTableDelegate {
    func showTable(sortKey: String, up: Bool, scope: Int) {
        searchViewController.segmentIndex = scope
        searchViewController.sortKey = sortKey
        self.present(searchViewController, animated: true, completion: nil)
    }
}
