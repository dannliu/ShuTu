//
//  STBaseCell.swift
//  MyColleague
//
//  Created by x4snowman on 2018/9/22.
//  Copyright © 2018 Beijing ShuTu Tech. Co.,Ltd. All rights reserved.
//

import UIKit

public enum CellLineSeparatorStyle: Int {
    case none   = 0x00
    case top    = 0x01
    case bottom = 0x10
    case both   = 0x11
}

open class STBaseCell: UITableViewCell {
    
    private var topLineSeparator: UIView?
    private var bottomLineSeparator: UIView?
    
    private var topLeadingConstraint: NSLayoutConstraint?
    private var topTrailingConstraint: NSLayoutConstraint?
    
    private var bottomLeadingConstraint: NSLayoutConstraint?
    private var bottomTrailingConstraint: NSLayoutConstraint?
    
    public override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    }
    
    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    public static var defaultCell: STBaseCell {
        return STBaseCell()
    }
    
    private func makeLineSeparator() -> UIView {
        let v = UIView()
        v.backgroundColor = UIColor.System.TableView.lineSeparator
        return v
    }
    
    public func setLineSeparatorStyle(_ style: CellLineSeparatorStyle) {
        switch style {
        case .none:
            topLineSeparator?.isHidden = true
            bottomLineSeparator?.isHidden = true
        case .top:
            addTopLineSeparator()
            bottomLineSeparator?.isHidden = true
        case .bottom:
            addBottomLineSeparator()
            topLineSeparator?.isHidden = true
        case .both:
            addTopLineSeparator()
            addBottomLineSeparator()
        }
    }
    
    public func setLineSepartorLeadingIndention(top: CGFloat = STSize.Margin.m16,
                                                bottom: CGFloat = STSize.Margin.m16) {
        topLeadingConstraint?.constant = top
        bottomLeadingConstraint?.constant = bottom
    }
    
    public func setLineSepartorTrailingIndention(top: CGFloat = STSize.Margin.m16,
                                                 bottom: CGFloat = STSize.Margin.m16) {
        topTrailingConstraint?.constant = top
        bottomTrailingConstraint?.constant = bottom
    }
    
    private func addTopLineSeparator() {
        if topLineSeparator == nil {
            topLineSeparator = makeLineSeparator()
            topLineSeparator?.translatesAutoresizingMaskIntoConstraints = false
            self.addSubview(topLineSeparator!)
            if let sv = topLineSeparator!.superview {
                topLeadingConstraint = topLineSeparator?.leadingTo(sv, offset: STSize.Margin.m16)
                topTrailingConstraint = sv.trailingTo(topLineSeparator!)
                NSLayoutConstraint.activate([
                    topLineSeparator!.heightAs(STSize.unit),
                    topLineSeparator!.topTo(sv),
                    topLeadingConstraint!,
                    topTrailingConstraint!
                ])
            }
        }
        topLineSeparator?.isHidden = false
    }
    
    private func addBottomLineSeparator() {
        if bottomLineSeparator == nil {
            bottomLineSeparator = makeLineSeparator()
            bottomLineSeparator?.translatesAutoresizingMaskIntoConstraints = false
            self.addSubview(bottomLineSeparator!)
            if let sv = bottomLineSeparator!.superview {
                bottomLeadingConstraint = bottomLineSeparator?.leadingTo(sv, offset: STSize.Margin.m16)
                bottomTrailingConstraint = sv.trailingTo(bottomLineSeparator!)
                NSLayoutConstraint.activate([
                    bottomLineSeparator!.heightAs(STSize.unit),
                    bottomLineSeparator!.bottomTo(sv),
                    bottomLeadingConstraint!,
                    bottomTrailingConstraint!
                ])
            }
        }
        bottomLineSeparator?.isHidden = false
    }
}
