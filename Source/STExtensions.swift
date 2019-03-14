//
//  STExtensions.swift
//  STKit
//
//  Created by x4snowman on 2018/10/9.
//  Copyright © 2018 liudanyun.com. All rights reserved.
//

import UIKit
import Foundation

// MARK: - UITableView

protocol STCellProtocol: AnyObject {
    static var reuseid: String { get }
}

extension UITableView {
    
    public func stRegister<T: UITableViewCell>(_ cellType: T.Type) {
        register(cellType, forCellReuseIdentifier: cellType.reuseid)
    }
    
    public func stDequeue<T: UITableViewCell>(_ cellType: T.Type, for indexPath: IndexPath) -> T {
        return dequeueReusableCell(withIdentifier: cellType.reuseid, for: indexPath) as! T
    }
}

extension UITableViewCell: STCellProtocol {
    class var reuseid: String {
        return NSStringFromClass(self)
    }
}

// MARK: - UIColor

extension UIColor {
    
    public convenience init(red: Int, green: Int, blue: Int, alpha: CGFloat = 1.0) {
        let base: CGFloat = 255.0
        self.init(red: CGFloat(red)/base, green: CGFloat(green)/base, blue: CGFloat(blue)/base, alpha: alpha)
    }
    
    
    public convenience init(rgb: Int, alpha: CGFloat = 1.0) {
        self.init(
            red: (rgb >> 16) & 0xFF,
            green: (rgb >> 8) & 0xFF,
            blue: rgb & 0xFF,
            alpha: alpha
        )
    }
    
    public struct System {
        
        public struct TableView {
            static let lineSeparator = UIColor(rgb: 0xC7C7CC)
            static let background = UIColor(rgb: 0xF2F2F2)
        }
    }
}

// MARK: - Auto Layout

extension UIView {
    
    public func makeOnlyAutoLayout() {
        translatesAutoresizingMaskIntoConstraints = false
    }
}


public protocol STLayoutAnchor: AnyObject {
    var bottomAnchor: NSLayoutYAxisAnchor { get }
    var centerXAnchor: NSLayoutXAxisAnchor { get }
    var centerYAnchor: NSLayoutYAxisAnchor { get }
    var heightAnchor: NSLayoutDimension { get }
    var leadingAnchor: NSLayoutXAxisAnchor { get }
    var leftAnchor: NSLayoutXAxisAnchor { get }
    var rightAnchor: NSLayoutXAxisAnchor { get }
    var topAnchor: NSLayoutYAxisAnchor { get }
    var trailingAnchor: NSLayoutXAxisAnchor { get }
    var widthAnchor: NSLayoutDimension { get }
}

extension STLayoutAnchor {
    
    public func leadingTo(_ view: STLayoutAnchor, offset: CGFloat = 0) -> NSLayoutConstraint {
        return leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: offset)
    }
    
    public func trailingTo(_ view: STLayoutAnchor, offset: CGFloat = 0) -> NSLayoutConstraint {
        return trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -offset)
    }
    
    public func hNextTo(_ view: STLayoutAnchor, offset: CGFloat = 0) -> NSLayoutConstraint {
        return leadingAnchor.constraint(equalTo: view.trailingAnchor, constant: offset)
    }
    
    public func topTo(_ view: STLayoutAnchor, offset: CGFloat = 0) -> NSLayoutConstraint {
        return topAnchor.constraint(equalTo: view.topAnchor, constant: offset)
    }
    
    public func safeTopTo(_ view: UIView, offset: CGFloat = 0) -> NSLayoutConstraint {
        if #available(iOS 11, *) {
            return topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: offset)
        } else {
            return topAnchor.constraint(equalTo: view.topAnchor, constant: offset)
        }
    }
    
    public func bottomTo(_ view: STLayoutAnchor, offset: CGFloat = 0) -> NSLayoutConstraint {
        return bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -offset)
    }
    
    public func safeBottomTo(_ view: UIView, offset: CGFloat = 0) -> NSLayoutConstraint {
        if #available(iOS 11, *) {
            return bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -offset)
        } else {
            return bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -offset)
        }
    }
    
    public func vNextTo(_ view: STLayoutAnchor, offset: CGFloat = 0) -> NSLayoutConstraint {
        return topAnchor.constraint(equalTo: view.bottomAnchor, constant: offset)
    }
    
    public func heightAs(_ constant: CGFloat) -> NSLayoutConstraint {
        return heightAnchor.constraint(equalToConstant: constant)
    }
    
    public func widthAs(_ constant: CGFloat) -> NSLayoutConstraint {
        return widthAnchor.constraint(equalToConstant: constant)
    }
    
    public func heightEqualTo(_ view: STLayoutAnchor) -> NSLayoutConstraint {
        return heightAnchor.constraint(equalTo: view.heightAnchor)
    }
    
    public func heightEqualToWidth() -> NSLayoutConstraint {
        return heightAnchor.constraint(equalTo: widthAnchor)
    }
    
    public func widthEqualTo(_ view: STLayoutAnchor) -> NSLayoutConstraint {
        return widthAnchor.constraint(equalTo: view.widthAnchor)
    }
    
    public func widthEqualToHeight() -> NSLayoutConstraint {
        return widthAnchor.constraint(equalTo: heightAnchor)
    }
    
    public func centerXTo(_ view: STLayoutAnchor, offset: CGFloat = 0) -> NSLayoutConstraint {
        return centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: offset)
    }
    
    public func centerYTo(_ view: STLayoutAnchor, offset: CGFloat = 0) -> NSLayoutConstraint {
        return centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: offset)
    }
    
    public func innerTo(_ view: STLayoutAnchor, padding: CGFloat = 0) -> [NSLayoutConstraint] {
        return [
            topTo(view, offset: padding),
            leadingTo(view, offset: padding),
            bottomTo(view, offset: padding),
            trailingTo(view, offset: padding)
        ]
    }
    
    public func safeInnerTo(_ view: UIView, padding: CGFloat = 0) -> [NSLayoutConstraint] {
        return [
            safeTopTo(view, offset: padding),
            leadingTo(view, offset: padding),
            safeBottomTo(view, offset: padding),
            trailingTo(view, offset: padding)
        ]
    }
}

extension NSLayoutConstraint {
    
    public static func activate(_ constraints: NSLayoutConstraint...) {
        activate(constraints)
    }
    
    public static func activate(_ constraints: [NSLayoutConstraint], _ remains: NSLayoutConstraint...) {
        activate(constraints)
        activate(remains)
    }
}

extension UIView: STLayoutAnchor {}

extension UILayoutGuide: STLayoutAnchor {}

extension UIImage {
    
    public static func stMake(color: UIColor, height: CGFloat = 1.0) -> UIImage {
        UIGraphicsBeginImageContextWithOptions(CGSize(width: 1, height: height), true, 0)
        color.setFill()
        UIRectFill(CGRect(x: 0, y: 0, width: 1, height: height))
        let img = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return img!
    }
    
    public var pixelWidth: CGFloat {
        return size.width * scale
    }
    
    public var pixelHeight: CGFloat {
        return size.height * scale
    }
}


// MARK: - Data

extension Data {
    public var hexDescription: String {
        return reduce("") {$0 + String(format: "%02x", $1)}
    }
}
