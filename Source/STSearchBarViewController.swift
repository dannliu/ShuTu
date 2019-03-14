//
//  STSearchBarViewController.swift
//  STKit
//
//  Created by x4snowman on 2019/2/25.
//  Copyright © 2019 liudanyun.com. All rights reserved.
//

import UIKit


open class STSearchBarViewController: STBaseTableViewController {
    
    public var searchBar: UISearchBar!
        
    override open func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.System.TableView.background
        searchBar = UISearchBar()
        searchBar.barTintColor = UIColor.System.TableView.background
        searchBar.isTranslucent = false
        view.addSubview(searchBar)
        searchBar.makeOnlyAutoLayout()
        NSLayoutConstraint.activate(
            searchBar.innerTo(tableViewTopLayoutGuide)
        )        
    }
}
