//
//  STTableSectionHeaderView.swift
//  MyColleague
//
//  Created by x4snowman on 2018/9/22.
//  Copyright © 2018 Beijing ShuTu Tech. Co.,Ltd. All rights reserved.
//

import UIKit

open class STTableViewHeaderFooterView: UITableViewHeaderFooterView {

    public static let reuseIdentifier: String = "STTableSectionHeaderView"
    
    var titleLabel: UILabel!
    
    public override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        backgroundView = UIView()
        backgroundView?.backgroundColor = UIColor.System.TableView.background        
    }
    
    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}
