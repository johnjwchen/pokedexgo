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
        else {
            let type = p![0] as! Int
            p = [DexType(rawValue: type)!, p![1]]
        }
        return [p!]
    }()
    
    deinit {
        // save current viewing page
        NotificationCenter.default.removeObserver(self)
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
    fileprivate func add(page: [Any], insertIndex: Int) -> Int {
        pageArray.insert(page, at: insertIndex)
        if pageArray.count >= PGPageViewController.MaxPageAllowed {
            pageArray.remove(at: 0)
            return insertIndex - 1
        }
        return insertIndex
    }
    
    
    fileprivate func newTableViewController(page: [Any], index: Int) -> UIViewController {
        let type = page[0] as! DexType
        let key = page[1] as! String
        let vc = storyboard!.instantiateViewController(withIdentifier: "DexTableViewController") as! DexTableViewController
        vc.setDex(dexType: type, dexKey: key)
        vc.showSortDelegate = self
        vc.viewPageDelegate = self
        // must set the pageIndex
        vc.pageIndex = index
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
//        delegate = self
        
        let firstViewController = newTableViewController(page: pageArray.first as! [Any], index: 0)
        setViewControllers([firstViewController],
                           direction: .forward,
                           animated: true,
                           completion: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(handleApplicationResignActive(notification:)), name: ApplicationResignActiveNotification, object: nil)
    }
    
    func handleApplicationResignActive(notification: Notification) {
        let currentVC = self.viewControllers!.first as! DexTableViewController
        let p = pageArray[currentVC.pageIndex] as! [Any]
        let type = p[0] as! DexType
        let pdata = [type.rawValue, p[1] as! String] as [Any]
        UserDefaults.standard.setValue(pdata, forKey: PGPageViewController.CurrentPageKey)
        UserDefaults.standard.synchronize()
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
        let p = [type, key] as [Any]
        let currentVC = self.viewControllers!.first as! DexTableViewController
        let currentP = page(index: currentVC.pageIndex)!
        if currentP[0] as! DexType == p[0] as! DexType &&
            currentP[1] as! String == p[1] as! String {
            // same page
            return
        }
        let insertIndex = self.add(page: p, insertIndex: currentVC.pageIndex + 1)
        setViewControllers([newTableViewController(page: p, index: insertIndex)], direction: .forward, animated: true, completion: nil)
    }
}


extension PGPageViewController: UIPageViewControllerDataSource {
    func viewController(forIndex: Int) -> UIViewController? {
        let p = self.page(index: forIndex)
        guard p != nil else {
            return nil
        }
        return self.newTableViewController(page: p!, index: forIndex)
    }
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        let currentVC = self.viewControllers!.first as! DexTableViewController
        return self.viewController(forIndex: currentVC.pageIndex + 1)
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        let currentVC = self.viewControllers!.first as! DexTableViewController
        return self.viewController(forIndex: currentVC.pageIndex - 1)
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
