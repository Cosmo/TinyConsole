//
//  Delegate.swift
//  TinyConsole
//
//  Created by Devran Uenal on 11.12.16.
//
//

import TinyConsole
import UIKit

class MainTableViewDelegate: NSObject, UITableViewDelegate {
    func tableView(_: UITableView, didSelectRowAt indexPath: IndexPath) {
        TinyConsole.print("Tapped on \(indexPath.row)")
    }
}
