//
//  GroupedTableViewController.swift
//  MyColleague
//
//  Created by x4snowman on 2018/9/24.
//  Copyright © 2018 Beijing ShuTu Tech. Co.,Ltd. All rights reserved.
//

import UIKit

open class STGroupedTableViewController: STBaseTableViewController {

    public init() {
        super.init(style: .grouped)
    }
        
    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    open override func viewDidLoad() {
        super.viewDidLoad()
        tableView.sectionFooterHeight = 0
        tableView.register(STTableViewHeaderFooterView.self, forHeaderFooterViewReuseIdentifier: STTableViewHeaderFooterView.reuseIdentifier)
    }

    // MARK: - Table view data source
    
    open override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return tableView.dequeueReusableHeaderFooterView(withIdentifier: STTableViewHeaderFooterView.reuseIdentifier)
    }
}
