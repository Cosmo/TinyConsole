//
//  TinyConsoleThreeTapDelegate.swift
//  TinyConsole
//
//  Created by Chang, Hao on 23/12/2016.
//
//

import UIKit

/**
 Implement this protocol to delegate 3 finger tag actions
 */
@objc public protocol TinyConsoleThreeTapDelegate: class {
    /**
     If the default actions is included (send email & clear console)
     */
    @objc optional var isWithDefaultActions: Bool {get}
    /**
     Total number of additional actions
     */
    var numberOfAdditionalActions : Int {get}
    /**
     Title of actions
     */
    func actionTitle(atIndex index: Int) -> String
    /**
     UIAlertActionStyle of actions with default value `.default`
     */
    @objc optional func actionStyle(atIndex index: Int) -> UIAlertActionStyle
    /**
     Action handler with default value `nil`
     */
    @objc optional func actionHandler(atIndex index: Int) -> ((UIAlertAction)->Void)?
}
