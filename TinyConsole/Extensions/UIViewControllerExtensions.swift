//
//  UIViewControllerExtensions.swift
//  TinyConsole
//
//  Created by Devran on 30.09.19.
//

import UIKit

internal extension UIViewController {
    func removeAllChildren() {
        children.forEach {
            $0.willMove(toParent: nil)
        }
        
        for view in view.subviews {
            view.removeFromSuperview()
        }
        children.forEach {
            $0.removeFromParent()
        }
    }
}
