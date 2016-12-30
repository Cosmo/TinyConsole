//
//  TinyConsoleController.swift
//  TinyConsole
//
//  Created by Devran Uenal on 28.11.16.
//
//

import UIKit

open class TinyConsoleController: UIViewController {
    
    /// the kind of window modes that are supported by TinyConsole
    ///
    /// - collapsed: the console is hidden
    /// - expanded: the console is shown
    private enum WindowMode {
        case collapsed
        case expanded
    }
    
    // MARK: - Private Properties -
    private var rootViewController: UIViewController
    
    private var consoleViewController: TinyConsoleViewController = {
        return TinyConsoleViewController()
    }()
    
    private lazy var consoleViewHeightConstraint: NSLayoutConstraint? = {
        if #available(iOS 9, *) {
            return self.consoleViewController.view.heightAnchor.constraint(equalToConstant: 0)
        } else {
            return NSLayoutConstraint(item: self.consoleViewController.view, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: 0)
        }
    }()
    
    private let consoleFrameHeight: CGFloat = 120
    private var expandedHeight: CGFloat = 140
    
    private lazy var consoleFrame: CGRect = {
        
        var consoleFrame = self.view.bounds
        consoleFrame.size.height -= self.consoleFrameHeight
        
        return consoleFrame
    }()
    
    private var consoleWindowMode: WindowMode = .collapsed {
        didSet {
            consoleViewHeightConstraint?.isActive = false
            consoleViewHeightConstraint?.constant = consoleWindowMode == .collapsed ? 0 : self.expandedHeight
            consoleViewHeightConstraint?.isActive = true
        }
    }
    
    // MARK: - Initializer -
    public init(rootViewController: UIViewController) {
        self.rootViewController = rootViewController
        super.init(nibName: nil, bundle: nil)
    }
    
    public init(rootViewController: UIViewController, expandedHeight: CGFloat) {
        self.rootViewController = rootViewController
        self.expandedHeight = expandedHeight
        super.init(nibName: nil, bundle: nil)
    }
    
    required public init?(coder aDecoder: NSCoder) {
        assertionFailure("Interface Builder is not supported")
        self.rootViewController = UIViewController()
        super.init(coder: aDecoder)
    }
    
    // MARK: - Public Methods -
    override open func viewDidLoad() {
        super.viewDidLoad()
        
        addChildViewController(consoleViewController)
        consoleViewController.view.frame = consoleFrame
        view.addSubview(consoleViewController.view)
        consoleViewController.didMove(toParentViewController: self)
        
        addChildViewController(rootViewController)
        rootViewController.view.frame = CGRect(x: consoleFrame.minX, y: consoleFrame.maxY, width: view.bounds.width, height: 120)
        view.addSubview(rootViewController.view)
        rootViewController.didMove(toParentViewController: self)
        
        setupConstraints()
    }
    
    open override func motionBegan(_ motion: UIEventSubtype, with event: UIEvent?) {
        if (motion == UIEventSubtype.motionShake) {
            consoleWindowMode = consoleWindowMode == .collapsed ? .expanded : .collapsed
            UIView.animate(withDuration: 0.25) {
                self.view.layoutIfNeeded()
            }
        }
    }
    
    // MARK: - Private Methods -
    private func setupConstraints() {
        
        rootViewController.view.attach(anchors: [.top], to: view)
        
        consoleViewController.view.attach(anchors: [.bottom], to: view)
        consoleViewHeightConstraint?.isActive = true
        
        if #available(iOS 9, *) {
            
            rootViewController.view.bottomAnchor.constraint(equalTo: consoleViewController.view.topAnchor).isActive = true
        } else {
            
            NSLayoutConstraint(item: (rootViewController.view)!,
                               attribute: .bottom,
                               relatedBy: .equal,
                               toItem: consoleViewController.view,
                               attribute: .top,
                               multiplier: 1.0,
                               constant: 0)
                .isActive = true
        }
    }
}
