//
//  TinyConsoleController.swift
//  TinyConsole
//
//  Created by Devran Uenal on 28.11.16.
//
//

import UIKit

enum TinyConsoleWindowMode {
    case collapsed
    case expanded
}

open class TinyConsoleController: UIViewController {
    var rootViewController: UIViewController?
    
    var consoleViewController: TinyConsoleViewController = {
        return TinyConsoleViewController()
    }()
    
    var consoleWindowMode: TinyConsoleWindowMode = .collapsed {
        didSet {
            self.consoleViewHeightConstraint?.isActive = false
            self.consoleViewHeightConstraint?.constant = self.consoleWindowMode == .collapsed ? 0 : 140
            self.consoleViewHeightConstraint?.isActive = true
        }
    }
    
    public init(rootViewController: UIViewController) {
        self.rootViewController = rootViewController
        super.init(nibName: nil, bundle: nil)
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override open func viewDidLoad() {
        super.viewDidLoad()
        
        var consoleFrame = self.view.bounds
        consoleFrame.size.height = self.view.bounds.height - 120
        
        self.addChildViewController(self.consoleViewController)
        self.consoleViewController.view.frame = consoleFrame
        self.view.addSubview(self.consoleViewController.view)
        self.consoleViewController.didMove(toParentViewController: self)
        
        if let content = self.rootViewController {
            self.addChildViewController(content)
            content.view.frame = CGRect(x: consoleFrame.minX, y: consoleFrame.maxY, width: self.view.bounds.width, height: 120)
            self.view.addSubview(content.view)
            content.didMove(toParentViewController: self)
        }
        
        self.setupConstraints()
    }
    
    lazy var consoleViewHeightConstraint: NSLayoutConstraint? = {
        if #available(iOS 9, *) {
            return self.consoleViewController.view.heightAnchor.constraint(equalToConstant: 0)
        } else {
            return NSLayoutConstraint(item: self.consoleViewController.view, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: 0)
        }
    }()
    
    func setupConstraints() {
        if #available(iOS 9, *) {
            self.rootViewController?.view.translatesAutoresizingMaskIntoConstraints = false
            self.rootViewController?.view.topAnchor.constraint(equalTo: self.view.topAnchor).isActive = true
            self.rootViewController?.view.leftAnchor.constraint(equalTo: self.view.leftAnchor).isActive = true
            self.rootViewController?.view.rightAnchor.constraint(equalTo: self.view.rightAnchor).isActive = true
            
            self.consoleViewController.view.translatesAutoresizingMaskIntoConstraints = false
            self.consoleViewController.view.bottomAnchor.constraint(equalTo: self.view.bottomAnchor).isActive = true
            self.consoleViewController.view.leftAnchor.constraint(equalTo: self.view.leftAnchor).isActive = true
            self.consoleViewController.view.rightAnchor.constraint(equalTo: self.view.rightAnchor).isActive = true
            
            self.consoleViewHeightConstraint?.isActive = true
            
            self.rootViewController?.view.bottomAnchor.constraint(equalTo: self.consoleViewController.view.topAnchor).isActive = true
        } else {
            self.rootViewController?.view.translatesAutoresizingMaskIntoConstraints = false
            NSLayoutConstraint(item: (self.rootViewController?.view)!, attribute: .top, relatedBy: .equal, toItem: self.view, attribute: .top, multiplier: 1.0, constant: 0).isActive = true
            NSLayoutConstraint(item: (self.rootViewController?.view)!, attribute: .left, relatedBy: .equal, toItem: self.view, attribute: .left, multiplier: 1.0, constant: 0).isActive = true
            NSLayoutConstraint(item: (self.rootViewController?.view)!, attribute: .right, relatedBy: .equal, toItem: self.view, attribute: .right, multiplier: 1.0, constant: 0).isActive = true
            
            self.consoleViewController.view.translatesAutoresizingMaskIntoConstraints = false
            NSLayoutConstraint(item: self.consoleViewController.view, attribute: .bottom, relatedBy: .equal, toItem: self.view, attribute: .bottom, multiplier: 1.0, constant: 0).isActive = true
            NSLayoutConstraint(item: self.consoleViewController.view, attribute: .left, relatedBy: .equal, toItem: self.view, attribute: .left, multiplier: 1.0, constant: 0).isActive = true
            NSLayoutConstraint(item: self.consoleViewController.view, attribute: .right, relatedBy: .equal, toItem: self.view, attribute: .right, multiplier: 1.0, constant: 0).isActive = true
            
            self.consoleViewHeightConstraint?.isActive = true
            
            NSLayoutConstraint(item: (self.rootViewController?.view)!, attribute: .bottom, relatedBy: .equal, toItem: self.consoleViewController.view, attribute: .top, multiplier: 1.0, constant: 0).isActive = true
        }
    }
    
    open override func updateViewConstraints() {
        super.updateViewConstraints()
    }
    
    open override func motionBegan(_ motion: UIEventSubtype, with event: UIEvent?) {
        if (motion == UIEventSubtype.motionShake) {
            self.consoleWindowMode = self.consoleWindowMode == .collapsed ? .expanded : .collapsed
            UIView.animate(withDuration: 0.25) {
                self.view.layoutIfNeeded()
            }
        }
    }
    
    open override func motionEnded(_ motion: UIEventSubtype, with event: UIEvent?) {
        
    }
}
