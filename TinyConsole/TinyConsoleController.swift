//
//  TinyConsoleController.swift
//  TinyConsole
//
//  Created by Devran Uenal on 28.11.16.
//
//

import UIKit

/// This UIViewController holds both, the `rootViewController`
/// of your application and the `consoleViewController`.
open class TinyConsoleController: UIViewController {
    /// The kind of window modes that are supported by TinyConsole
    ///
    /// - collapsed: the console is hidden
    /// - expanded: the console is shown
    public enum WindowMode {
        case collapsed
        case expanded
    }
    
    // MARK: - Private Properties -
    private var animationDuration = 0.25
    var rootViewController: UIViewController {
        didSet {
            setupViewControllers()
            setupConstraints()
        }
    }

    var consoleViewController: TinyConsoleViewController = {
        TinyConsoleViewController()
    }()

    private lazy var consoleViewHeightConstraint: NSLayoutConstraint? = {
        return consoleViewController.view.heightAnchor.constraint(equalToConstant: 0)
    }()
    
    public var consoleHeight: CGFloat = 200 {
        didSet {
            UIView.animate(withDuration: animationDuration) {
                self.updateHeightConstraint()
                self.view.layoutIfNeeded()
            }
        }
    }
    
    // MARK: - Public Properties -
    
    public var consoleWindowMode: WindowMode = .collapsed {
        didSet {
            updateHeightConstraint()
        }
    }
    
    func updateHeightConstraint() {
        consoleViewHeightConstraint?.isActive = false
        consoleViewHeightConstraint?.constant = consoleWindowMode == .collapsed ? 0 : consoleHeight
        consoleViewHeightConstraint?.isActive = true
    }

    // MARK: - Initializer -

    init() {
        rootViewController = UIViewController()
        super.init(nibName: nil, bundle: nil)
    }

    public required init?(coder aDecoder: NSCoder) {
        assertionFailure("Interface Builder is not supported")
        rootViewController = UIViewController()
        super.init(coder: aDecoder)
    }

    // MARK: - Public Methods -

    open override func viewDidLoad() {
        super.viewDidLoad()

        setupViewControllers()
        setupConstraints()
    }

    open override func motionBegan(_ motion: UIEvent.EventSubtype, with event: UIEvent?) {
        if motion == .motionShake {
            toggleWindowMode()
        }
    }

    // MARK: - Private Methods -
    
    internal func toggleWindowMode() {
        consoleWindowMode = consoleWindowMode == .collapsed ? .expanded : .collapsed
        UIView.animate(withDuration: animationDuration) {
            self.view.layoutIfNeeded()
        }
    }

    private func setupViewControllers() {
        removeAllChildren()
        
        addChild(consoleViewController)
        view.addSubview(consoleViewController.view)
        consoleViewController.didMove(toParent: self)

        addChild(rootViewController)
        view.addSubview(rootViewController.view)
        rootViewController.didMove(toParent: self)
    }

    private func setupConstraints() {
        rootViewController.view.attach(anchor: .top, to: view)

        consoleViewController.view.attach(anchor: .bottom, to: view)
        consoleViewHeightConstraint?.isActive = true

        rootViewController.view.bottomAnchor.constraint(equalTo: consoleViewController.view.topAnchor).isActive = true
    }
}

