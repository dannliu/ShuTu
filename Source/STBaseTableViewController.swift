//
//  BirdLoadingTableViewController.swift
//  Bird
//
//  Created by x4snowman on 2018/9/3.
//  Copyright © 2018 WhoseBird. All rights reserved.
//

import UIKit

open class STBaseTableViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    public var tableView: STTableView!
    
    public var tableViewTopLayoutGuide: UILayoutGuide = UILayoutGuide()
    
    private var tableViewStyle: UITableView.Style!
    
    public init(style: UITableView.Style = .plain) {
        super.init(nibName: nil, bundle: nil)
        tableView = STTableView(frame: CGRect.zero, style: style)
    }
    
    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override open func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.System.TableView.background

        view.addLayoutGuide(tableViewTopLayoutGuide)
        let lycsHeight = tableViewTopLayoutGuide.heightAs(0)
        lycsHeight.priority = .defaultLow
        NSLayoutConstraint.activate(
            lycsHeight,
            tableViewTopLayoutGuide.leadingTo(view),
            tableViewTopLayoutGuide.trailingTo(view)
        )
        //To fix padding when use grouped table view controller
        tableView.tableHeaderView = UIView(frame: CGRect(x: 0, y: 0, width: 0, height: CGFloat.leastNormalMagnitude))
        tableView.tableFooterView = UIView()
        tableView.separatorStyle = .none
        tableView.backgroundColor = UIColor.System.TableView.background
        tableView.estimatedRowHeight = UITableView.automaticDimension
        tableView.rowHeight = UITableView.automaticDimension
        tableView.delegate = self
        tableView.dataSource = self
        view.addSubview(tableView)
        tableView.makeOnlyAutoLayout()
        NSLayoutConstraint.activate(
            tableView.vNextTo(tableViewTopLayoutGuide),
            tableView.leadingTo(view),
            tableView.trailingTo(view)
        )
    }
    
    override open func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        if let navigationBar = navigationController?.navigationBar, navigationBar.isTranslucent {
            tableViewTopLayoutGuide.topTo(view).isActive = true
        } else {
            tableViewTopLayoutGuide.safeTopTo(view).isActive = true
        }
        
        if hidesBottomBarWhenPushed {
            tableView.bottomTo(view).isActive = true
        } else {
            tableView.safeBottomTo(view).isActive = true
        }
    }
    
    override open func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.indexPathsForSelectedRows?.forEach {
            self.tableView.deselectRow(at: $0, animated: true)
        }
    }
    
    open func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    open func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
    }
    
    open func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return UITableViewCell()
    }
    
    open func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
    
    open func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 0.0
    }
    
    open func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return nil
    }
    
    open func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0.0
    }
    
    open func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return nil
    }
    
    open func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return nil
    }
    
    open func tableView(_ tableView: UITableView, titleForFooterInSection section: Int) -> String? {
        return nil
    }
    
    open func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    open func tableView(_ tableView: UITableView, accessoryButtonTappedForRowWith indexPath: IndexPath) {
        
    }
}

public class STTableView: UITableView {
    
    override public init(frame: CGRect, style: UITableView.Style) {
        super.init(frame: frame, style: style)
        setupKeyboard()
    }
    
    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupKeyboard()
    }
    
    public var loadingControl: STLoadingControl? {
        didSet {
            self.addObserver(self, forKeyPath: "contentOffset", options: .initial, context: nil)
            loadingControl?.addObserver(self, forKeyPath: "loading", options: .initial, context: nil)
        }
    }
    
    override public func observeValue(forKeyPath keyPath: String?, of object: Any?,
                                      change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if keyPath == "contentOffset" {
            if let lc = loadingControl,
                !lc.loading
                && lc.hasMoreData
                && contentSize.height > frame.height
                && contentOffset.y + frame.height > contentSize.height + STLoadingControl.height {
                lc.beginLoading()
                tableFooterView = loadingControl
                DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(1)) {
                    lc.sendActions(for: .valueChanged)
                }
                let feedback: UIImpactFeedbackGenerator? = UIImpactFeedbackGenerator(style: .medium)
                feedback?.prepare()
                feedback?.impactOccurred()
            }
        } else if keyPath == "loading" {
            tableFooterView = UIView()
        }
    }
    
    override open func layoutSubviews() {
        super.layoutSubviews()
        if let lc = loadingControl {
            lc.frame = CGRect(origin: lc.frame.origin, size: CGSize(width: frame.width, height: STLoadingControl.height))
        }
    }
    
    deinit {
        if let lc = loadingControl {
            removeObserver(self, forKeyPath: "contentOffset")
            lc.removeObserver(self, forKeyPath: "loading")
        }
        NotificationCenter.default.removeObserver(self)
    }
    
    //MARK: Keyboard
    
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
        if let rect: CGRect = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect {
            let inset = UIEdgeInsets(top: 0, left: 0, bottom: rect.height, right: 0)
            contentInset = inset
            scrollIndicatorInsets = inset
        }
    }
    
    @objc private func keyboardWillBeHidden(_ notification: Notification) {
        contentInset = UIEdgeInsets.zero
        scrollIndicatorInsets = UIEdgeInsets.zero
    }
}
