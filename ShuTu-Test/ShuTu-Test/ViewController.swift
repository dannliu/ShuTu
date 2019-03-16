//
//  ViewController.swift
//  ShuTu-Test
//
//  Created by x4snowman on 2019/3/15.
//  Copyright © 2019 liudanyun.com. All rights reserved.
//

import UIKit

class ViewController: STBaseTableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
    }
    
    @objc
    func load() {
        //todo
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 20
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = STBaseCell()
        cell.textLabel?.text = "Test"
        cell.backgroundColor = UIColor.red
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    
    }
    
    @IBAction func changeTranslucent() {
//        navigationController?.navigationBar.isTranslucent = !(navigationController?.navigationBar.isTranslucent ?? false)
        becomeFirstResponder()
    }
    
    override var canBecomeFirstResponder: Bool {
        return true
    }
}

