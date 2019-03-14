//
//  STToast.swift
//  ShuTu
//
//  Created by x4snowman on 2019/3/14.
//  Copyright © 2019 liudanyun.com. All rights reserved.
//

import UIKit
import MBProgressHUD

public class STToast {
    
    private static let stTextWindow: UIWindow = {
        let window = UIWindow(frame: UIScreen.main.bounds)
        window.windowLevel = UIWindow.Level.alert + 1
        return window
    }()
    
    
    public static func show(text: String?) {
        show(text:text, duration: 1.5, completion:nil)
    }
    
    public static func show(text: String?, duration:TimeInterval, completion:(()->Void)?) {
        DispatchQueue.main.async {
            stTextWindow.isHidden = false
            let hud = MBProgressHUD.showAdded(to: stTextWindow, animated: true)
            hud.mode = .text
            hud.label.text = text
            hud.bezelView.backgroundColor = UIColor(rgb: 0x000000, alpha: 0.8)
            hud.contentColor = UIColor.white
            let d = Int(duration * TimeInterval(1000))
            DispatchQueue.main.asyncAfter(deadline: .now() + .milliseconds(d), execute: {
                stTextWindow.isHidden = true
                hud.hide(animated: true)
                if let completion = completion {
                    completion()
                }
            })
        }
    }
}
