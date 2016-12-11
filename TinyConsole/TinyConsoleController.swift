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
            consoleViewHeightConstraint?.isActive = false
            consoleViewHeightConstraint?.constant = consoleWindowMode == .collapsed ? 0 : 140
            consoleViewHeightConstraint?.isActive = true
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
        
        var consoleFrame = view.bounds
        consoleFrame.size.height = view.bounds.height - 120
        
        addChildViewController(consoleViewController)
        consoleViewController.view.frame = consoleFrame
        view.addSubview(consoleViewController.view)
        consoleViewController.didMove(toParentViewController: self)
        
        if let content = rootViewController {
            addChildViewController(content)
            content.view.frame = CGRect(x: consoleFrame.minX, y: consoleFrame.maxY, width: view.bounds.width, height: 120)
            view.addSubview(content.view)
            content.didMove(toParentViewController: self)
        }
        
        setupConstraints()
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
            let rootViewControllerView = rootViewController?.view
            rootViewControllerView?.translatesAutoresizingMaskIntoConstraints = false
            rootViewControllerView?.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
            rootViewControllerView?.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
            rootViewControllerView?.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
            
            consoleViewController.view.translatesAutoresizingMaskIntoConstraints = false
            consoleViewController.view.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
            consoleViewController.view.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
            consoleViewController.view.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
            
            consoleViewHeightConstraint?.isActive = true
            
            rootViewController?.view.bottomAnchor.constraint(equalTo: consoleViewController.view.topAnchor).isActive = true
        } else {
            rootViewController?.view.translatesAutoresizingMaskIntoConstraints = false
            NSLayoutConstraint(item: (rootViewController?.view)!, attribute: .top, relatedBy: .equal, toItem: view, attribute: .top, multiplier: 1.0, constant: 0).isActive = true
            NSLayoutConstraint(item: (rootViewController?.view)!, attribute: .left, relatedBy: .equal, toItem: view, attribute: .left, multiplier: 1.0, constant: 0).isActive = true
            NSLayoutConstraint(item: (rootViewController?.view)!, attribute: .right, relatedBy: .equal, toItem: view, attribute: .right, multiplier: 1.0, constant: 0).isActive = true
            
            consoleViewController.view.translatesAutoresizingMaskIntoConstraints = false
            NSLayoutConstraint(item: consoleViewController.view, attribute: .bottom, relatedBy: .equal, toItem: view, attribute: .bottom, multiplier: 1.0, constant: 0).isActive = true
            NSLayoutConstraint(item: self.consoleViewController.view, attribute: .left, relatedBy: .equal, toItem: view, attribute: .left, multiplier: 1.0, constant: 0).isActive = true
            NSLayoutConstraint(item: self.consoleViewController.view, attribute: .right, relatedBy: .equal, toItem: view, attribute: .right, multiplier: 1.0, constant: 0).isActive = true
            
            consoleViewHeightConstraint?.isActive = true
            
            NSLayoutConstraint(item: (rootViewController?.view)!, attribute: .bottom, relatedBy: .equal, toItem: consoleViewController.view, attribute: .top, multiplier: 1.0, constant: 0).isActive = true
        }
    }
    
    open override func motionBegan(_ motion: UIEventSubtype, with event: UIEvent?) {
        if (motion == UIEventSubtype.motionShake) {
            consoleWindowMode = consoleWindowMode == .collapsed ? .expanded : .collapsed
            UIView.animate(withDuration: 0.25) {
                self.view.layoutIfNeeded()
            }
        }
    }
}
