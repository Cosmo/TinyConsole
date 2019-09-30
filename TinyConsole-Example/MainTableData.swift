//
//  MainTableData.swift
//  TinyConsole
//
//  Created by Devran Uenal on 11.12.16.
//
//

import TinyConsole
import UIKit

class MainTableData: NSObject {
}

enum Section: CaseIterable {
    case actions
    case numbered
    
    static func getSection(_ section: Int) -> Section {
        return self.allCases[section]
    }
}

enum ActionRow: String, CaseIterable {
    case toggle = "Toggle"
    case addLog = "Add Log"
    case addLine = "Add Line"
    case clear = "Clear"
    case resize = "Resize"
    
    static func getActionRow(_ actionRow: Int) -> ActionRow {
        return self.allCases[actionRow]
    }
}

extension MainTableData: UITableViewDataSource {
    func registerCellsForTableView(_ tableView: UITableView) {
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "default")
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        return Section.allCases.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch Section.getSection(section) {
        case .actions:
            return ActionRow.allCases.count
        case .numbered:
            return 30
        }
    }

    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        switch Section.getSection(section) {
        case .actions:
            return "Actions"
        case .numbered:
            return "Numbered Rows"
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "default", for: indexPath)
        switch Section.getSection(indexPath.section) {
        case .actions:
            cell.textLabel?.text = ActionRow.getActionRow(indexPath.row).rawValue
        case .numbered:
            cell.textLabel?.text = "Row \(indexPath.row)"
        }
        return cell
    }
}

extension MainTableData: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch Section.getSection(indexPath.section) {
        case .actions:
            didSelectActionRow(atIndexPath: indexPath)
        case .numbered:
            didSelectNumberedRow(atIndexPath: indexPath)
        }
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func didSelectActionRow(atIndexPath indexPath: IndexPath) {
        switch ActionRow.getActionRow(indexPath.row) {
        case .addLog:
            addLog()
        case .toggle:
            toggle()
        case .addLine:
            addLine()
        case .clear:
            clear()
        case .resize:
            resize()
        }
    }
    
    func didSelectNumberedRow(atIndexPath indexPath: IndexPath) {
        TinyConsole.print("Tapped on \(indexPath.row)")
    }
}

extension MainTableData {
    @objc func toggle() {
        TinyConsole.toggleWindowMode()
    }
    
    @objc func addLog() {
        TinyConsole.print("Hello World")
    }
    
    @objc func clear() {
        TinyConsole.clear()
    }
    
    @objc func addLine() {
        TinyConsole.addLine()
    }
    
    @objc func resize() {
        TinyConsole.setHeight(height: CGFloat.random(in: 120..<220))
    }
}

