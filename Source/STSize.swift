//
//  STSize.swift
//  MyColleague
//
//  Created by x4snowman on 2018/9/22.
//  Copyright © 2018 Beijing ShuTu Tech. Co.,Ltd. All rights reserved.
//

import Foundation
import CoreGraphics
import UIKit

public struct STSize {
    
    // leading, trailing, top, bottom
    public struct Margin {
        public static let m16: CGFloat = 16.0
        public static let m12: CGFloat = 12.0
        public static let m10: CGFloat = 10.0
        public static let m08: CGFloat = 8.0
        public static let m04: CGFloat = 4.0
    }
    
    // distance between elementes
    public struct Spacing {
        public static let s16: CGFloat = 16.0
        public static let s10: CGFloat = 10.0
        public static let s08: CGFloat = 8.0
        public static let s04: CGFloat = 4.0
    }
    
    public struct Corner {
        public static let c08: CGFloat = 8.0
    }
    
    public static let unit: CGFloat = 1 / UIScreen.main.scale
    
}
