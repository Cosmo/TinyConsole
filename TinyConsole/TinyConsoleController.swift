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
    enum WindowMode {
        case collapsed
        case expanded
    }

    // MARK: - Private Properties -

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
        if #available(iOS 9, *) {
            return self.consoleViewController.view.heightAnchor.constraint(equalToConstant: 0)
        } else {
            return NSLayoutConstraint(item: self.consoleViewController.view, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: 0)
        }
    }()

    private let consoleFrameHeight: CGFloat = 120
    private let expandedHeight: CGFloat = 140

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

    @available(*, deprecated, message: "use TinyConsole.createViewController instead")
    public init(rootViewController: UIViewController) {
        self.rootViewController = rootViewController
        super.init(nibName: nil, bundle: nil)
        TinyConsole.shared.consoleController = self
    }

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

    public var isExpanded: Bool {
        return consoleWindowMode == .expanded
    }

    open override func viewDidLoad() {
        super.viewDidLoad()

        setupViewControllers()
        setupConstraints()
    }

    open override func motionBegan(_ motion: UIEvent.EventSubtype, with _: UIEvent?) {
        if motion == .motionShake {
            consoleWindowMode = consoleWindowMode == .collapsed ? .expanded : .collapsed
            UIView.animate(withDuration: 0.25) {
                self.view.layoutIfNeeded()
            }
        }
    }

    // MARK: - Private Methods -

    private func setupViewControllers() {
        children.forEach {
            $0.willMove(toParent: nil)
        }

        for view in view.subviews {
            view.removeFromSuperview()
        }
        children.forEach {
            $0.removeFromParent()
        }

        addChild(consoleViewController)
        consoleViewController.view.frame = consoleFrame
        view.addSubview(consoleViewController.view)
        consoleViewController.didMove(toParent: self)

        addChild(rootViewController)
        rootViewController.view.frame = CGRect(x: consoleFrame.minX, y: consoleFrame.maxY, width: view.bounds.width, height: 120)
        view.addSubview(rootViewController.view)
        rootViewController.didMove(toParent: self)
    }

    private func setupConstraints() {

        rootViewController.view.attach(anchor: .top, to: view)

        consoleViewController.view.attach(anchor: .bottom, to: view)
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

fileprivate extension UIView {

    enum Anchor {
        case top
        case bottom
    }

    func attach(anchor: Anchor, to view: UIView) {

        translatesAutoresizingMaskIntoConstraints = false

        if #available(iOS 9, *) {

            switch anchor {
            case .top:
                topAnchor.constraint(equalTo: view.topAnchor).isActive = true
            case .bottom:
                bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
            }

            leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
            rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true

        } else {

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
