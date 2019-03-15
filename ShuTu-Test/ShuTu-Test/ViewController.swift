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
//        tableView.loadingControl = STLoadingControl()
//        tableView.loadingControl?.addTarget(self, action: #selector(load), for: .valueChanged)
        
        // Do any additional setup after loading the view, typically from a nib.
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
}

