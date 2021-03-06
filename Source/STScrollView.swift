//
//  STScrollView.swift
//  MyColleague
//
//  Created by x4snowman on 2018/9/7.
//  Copyright © 2018 Beijing ShuTu Tech. Co.,Ltd. All rights reserved.
//

import UIKit

public class STScrollView: UIScrollView {
    
    var contentInsetsBeforeKeyboardShow: UIEdgeInsets = UIEdgeInsets.zero
    var scrollIndicatorInsetsBeforeKeyboardShow: UIEdgeInsets = UIEdgeInsets.zero
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupKeyboard()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupKeyboard()
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    private func setupKeyboard() {
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(keyboardWasShown(_:)),
                                               name: UIResponder.keyboardDidShowNotification,
                                               object: nil)
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(keyboardWillBeHidden(_:)),
                                               name: UIResponder.keyboardWillHideNotification,
                                               object: nil)
    }
    
    @objc private func keyboardWasShown(_ notification: Notification) {
        contentInsetsBeforeKeyboardShow = contentInset
        scrollIndicatorInsetsBeforeKeyboardShow = scrollIndicatorInsets
        if let rect: CGRect = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect {
            let inset = UIEdgeInsets(top: 0, left: 0, bottom: rect.height, right: 0)
            contentInset = inset + contentInsetsBeforeKeyboardShow
            scrollIndicatorInsets = inset + scrollIndicatorInsetsBeforeKeyboardShow
        }
    }
    
    @objc private func keyboardWillBeHidden(_ notification: Notification) {
        contentInset = contentInsetsBeforeKeyboardShow
        scrollIndicatorInsets = scrollIndicatorInsetsBeforeKeyboardShow
    }
}
