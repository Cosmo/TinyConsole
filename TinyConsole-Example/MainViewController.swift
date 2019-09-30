//
//  MainViewController.swift
//  TinyConsole-Example
//
//  Created by Devran Uenal on 28.11.16.
//
//

import TinyConsole
import UIKit

class MainViewController: UITableViewController {
    lazy var mainTableData: MainTableData = {
        let mainTableData = MainTableData()
        mainTableData.registerCellsForTableView(tableView)
        return mainTableData
    }()

    init() {
        super.init(style: .grouped)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }
    
    func commonInit() {
        title = "Main"
    }

    override func viewDidLoad() {
        tableView.delegate = mainTableData
        tableView.dataSource = mainTableData

        super.viewDidLoad()
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

        printWelcome()
    }
}

extension MainViewController {
    func printWelcome() {
        TinyConsole.print("Welcome to TinyConsole")
        TinyConsole.addLine()
        TinyConsole.print("NOW", color: UIColor.red)
        TinyConsole.print("IN", color: UIColor.green)
        TinyConsole.print("COLOR", color: UIColor.blue)
        TinyConsole.addLine()
    }
}
