//
//  PGPageViewController.swift
//  PokedexGo
//
//  Created by JIAWEI CHEN on 3/4/17.
//  Copyright © 2017 PokGear. All rights reserved.
//

import UIKit

protocol ViewDexPageDelegate {
    func viewPage(type: DexType, key: String!)
}

class PGPageViewController: UIPageViewController {
    public static let CurrentPageKey = "CurrentPage"
    static public let MaxPageAllowed: Int = 100
    private lazy var pageArray: [Any] = {
        var p = UserDefaults.standard.array(forKey: PGPageViewController.CurrentPageKey)
        if p == nil {
            p = [DexType.Pokemon, "1"]
        }
        return [p!]
    }()
    
    deinit {
        // save current viewing page
        UserDefaults.standard.setValue(currentPage(), forKey: PGPageViewController.CurrentPageKey)
        UserDefaults.standard.synchronize()
    }
    
    
    fileprivate var pageIndex: Int = 0
    fileprivate func currentPage() -> [Any] {
        return pageArray[pageIndex] as! [Any]
    }
    fileprivate func page(index: Int) -> [Any]? {
        guard index >= 0 else {
            return nil
        }
        guard index < pageArray.count else {
            return nil
        }
        return pageArray[index] as? [Any]
    }
    fileprivate func add(page: [Any]) {
        pageIndex += 1
        pageArray.insert(page, at: pageIndex)
        
        if pageArray.count >= PGPageViewController.MaxPageAllowed {
            pageArray.remove(at: 0)
            pageIndex -= 1
        }
    }
    
    
    fileprivate func newTableViewController(page: [Any]) -> UIViewController {
        let type = page[0] as! DexType
        let key = page[1] as! String
        let vc = storyboard!.instantiateViewController(withIdentifier: "DexTableViewController") as! DexTableViewController
        vc.setDex(dexType: type, dexKey: key)
        vc.showSortDelegate = self
        vc.viewPageDelegate = self
        return vc
    }
    
    lazy var searchViewController: PGSearchViewController! = {
        let viewController = self.storyboard!.instantiateViewController(withIdentifier: "SearchViewController") as! PGSearchViewController
        viewController.viewPageDelegate = self
        return viewController
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.setNavigationBarHidden(true, animated: false)

        dataSource = self
        delegate = self
        
        let firstViewController = newTableViewController(page: currentPage())
        setViewControllers([firstViewController],
                           direction: .forward,
                           animated: true,
                           completion: nil)
        
    }
    
    func search() {
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

extension PGPageViewController: ViewDexPageDelegate {
    func viewPage(type: DexType, key: String!) {
        self.add(page: [type, key])
        setViewControllers([newTableViewController(page: self.currentPage())], direction: .forward, animated: true, completion: nil)
    }
}

extension PGPageViewController: UIPageViewControllerDelegate {
    public func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
        if completed {
            // update pageIndex
            var index: Int = pageIndex - 1
            let vc = self.viewControllers?[0] as! DexTableViewController
            let p = self.page(index: index)
            if p != nil {
                if vc.hasSame(page: p!) {
                    pageIndex = index
                    return
                }
            }
            index = pageIndex + 1
            let p2 = self.page(index: index)
            if p2 != nil {
                if vc.hasSame(page: p2!) {
                    pageIndex = index
                }
            }
        }
    }
}

extension PGPageViewController: UIPageViewControllerDataSource {
    func viewController(forIndex: Int) -> UIViewController? {
        let p = self.page(index: forIndex)
        guard p != nil else {
            return nil
        }
        return self.newTableViewController(page: p!)
    }
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        return self.viewController(forIndex: pageIndex + 1)
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        return self.viewController(forIndex: pageIndex - 1)
    }
}

extension PGPageViewController: ShowSortTableDelegate {
    func showTable(searchKey: String?, sortKey: String, up: Bool, scope: Int) {
        searchViewController.segmentIndex = scope
        searchViewController.sortKey = sortKey
        searchViewController.sortUp = up
        searchViewController.searchKey = searchKey
        searchViewController.setUpArrays()
        self.present(searchViewController, animated: true, completion: nil)
    }
}
