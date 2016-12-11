//
//  Delegate.swift
//  TinyConsole
//
//  Created by Devran Uenal on 11.12.16.
//
//

import UIKit
import TinyConsole

class MainTableViewDelegate: NSObject, UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        TinyConsole.print("Tapped on \(indexPath.row)")
    }
}
