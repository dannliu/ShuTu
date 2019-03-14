//
//  LoadingControl.swift
//  Bird
//
//  Created by x4snowman on 2018/9/3.
//  Copyright © 2018 WhoseBird. All rights reserved.
//

import UIKit

public class STLoadingControl: UIControl {
    
    static let height: CGFloat = 44.0
    
    private var _loading: Bool = false
    
    private var indicator: UIActivityIndicatorView!
    
    private var labelTitle: UILabel!
    
    public var hasMoreData: Bool = true
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        
        let container = UILayoutGuide()
        addLayoutGuide(container)
        NSLayoutConstraint.activate(
            container.topTo(self),
            container.bottomTo(self),
            container.centerXTo(self)
        )
        
        indicator = UIActivityIndicatorView(style: .gray)
        addSubview(indicator)
        indicator.makeOnlyAutoLayout()
        NSLayoutConstraint.activate(
            indicator.centerYTo(container),
            indicator.leadingTo(container)
        )
        labelTitle = UILabel()
        labelTitle.makeOnlyAutoLayout()
        addSubview(labelTitle)
        NSLayoutConstraint.activate(
            labelTitle.centerYTo(container),
            labelTitle.hNextTo(indicator, offset: 4.0),
            labelTitle.trailingTo(container)
        )
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public var loading: Bool {
        return _loading
    }
    
    public var attributedTitle: NSAttributedString! {
        didSet {
            labelTitle.attributedText = attributedTitle
        }
    }
    
    public func beginLoading() {
        _loading = true
        self.indicator.startAnimating()
    }
    
    public func endLoading() {
        self.willChangeValue(forKey: "loading")
        _loading = false
        self.didChangeValue(forKey: "loading")
        self.indicator.stopAnimating()
    }
    
    override public class var requiresConstraintBasedLayout: Bool {
        return false
    }
}
