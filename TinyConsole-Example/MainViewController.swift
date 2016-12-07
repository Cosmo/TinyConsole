//
//  MainViewController.swift
//  TinyConsole-Example
//
//  Created by Devran Uenal on 28.11.16.
//
//

import UIKit
import TinyConsole

class MainViewController: UITableViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.white
        
        self.tableView.register(UITableViewCell.self, forCellReuseIdentifier: "default")
        
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Add Log", style: UIBarButtonItemStyle.plain, target: self, action: #selector(addLog))
        self.navigationItem.rightBarButtonItems = [
            UIBarButtonItem(title: "Add Marker", style: UIBarButtonItemStyle.plain, target: self, action: #selector(addMarker)),
            UIBarButtonItem(title: "Clear", style: UIBarButtonItemStyle.plain, target: self, action: #selector(clear)),
        ]
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 30
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.tableView.dequeueReusableCell(withIdentifier: "default", for: indexPath)
        
        cell.textLabel?.text = "Row \(indexPath.row)"
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        TinyConsole.print("Tapped on \(indexPath.row)")
    }
    
    func addLog() {
        TinyConsole.print("hello world")
    }
    
    func clear() {
        TinyConsole.clear()
    }
    
    func addMarker() {
        TinyConsole.addMarker()
    }
}

