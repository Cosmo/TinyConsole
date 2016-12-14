//
//  Localization.swift
//  TinyConsole
//
//  Created by Devran Uenal on 13.12.16.
//
//

import Foundation

// MARK: - String Localization Extension
extension String {
    func localized(comment: String = "") -> String {
        return NSLocalizedString(self, tableName: nil, bundle: Bundle(for: TinyConsole.self), value: "", comment: comment)
    }
}
