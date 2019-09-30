//
//  UIViewExtensions.swift
//  TinyConsole
//
//  Created by Devran on 29.09.19.
//

import Foundation

internal extension UIView {
    enum Anchor {
        case top
        case bottom
    }
    
    func attach(anchor: Anchor, to view: UIView) {
        translatesAutoresizingMaskIntoConstraints = false
        switch anchor {
        case .top:
            topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        case .bottom:
            bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        }
        
        leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
    }
}
