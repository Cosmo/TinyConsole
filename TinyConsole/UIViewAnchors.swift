//
//  UIViewAnchors.swift
//  TinyConsole
//
//  Created by Marius Landwehr on 11.12.16.
//
//

extension UIView {
    
    enum Anchor {
        case top
        case bottom
    }
    
    func attach(anchors: [Anchor], to view: UIView) {
        
        translatesAutoresizingMaskIntoConstraints = false
        
        if #available(iOS 9, *) {
            
            for anchor in anchors {
                switch anchor {
                case .top:
                    topAnchor.constraint(equalTo: view.topAnchor).isActive = true
                case .bottom:
                    bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
                }
            }
            
            leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
            rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
            
        } else {
            
            for anchor in anchors {
                switch anchor {
                case .top:
                    NSLayoutConstraint(item: self,
                                       attribute: .top,
                                       relatedBy: .equal,
                                       toItem: view,
                                       attribute: .top,
                                       multiplier: 1.0,
                                       constant: 0)
                        .isActive = true
                case .bottom:
                    NSLayoutConstraint(item: self,
                                       attribute: .bottom,
                                       relatedBy: .equal,
                                       toItem: view,
                                       attribute: .bottom,
                                       multiplier: 1.0,
                                       constant: 0)
                        .isActive = true
                }
            }
            
            // left anchor
            NSLayoutConstraint(item: self,
                               attribute: .left,
                               relatedBy: .equal,
                               toItem: view,
                               attribute: .left,
                               multiplier: 1.0,
                               constant: 0)
                .isActive = true
            // right anchor
            NSLayoutConstraint(item: self,
                               attribute: .right,
                               relatedBy: .equal,
                               toItem: view,
                               attribute: .right,
                               multiplier: 1.0,
                               constant: 0)
                .isActive = true
        }
    }
}
