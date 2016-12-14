//
//  TinyConsoleViewController.swift
//  TinyConsole
//
//  Created by Devran Uenal on 28.11.16.
//
//

import UIKit
import MessageUI

class TinyConsoleViewController: UIViewController {
    
    // MARK: - Private Properties
    
    private let consoleTextView = UITextView.console
    
    // MARK: - Public Methods
    override open func viewDidLoad() {
        super.viewDidLoad()
        
        TinyConsole.shared.textView = consoleTextView
        view.addSubview(consoleTextView)
        
        addMarkerGesture()
        addCustomTextGesture()
        addAdditionalActionsGesture()
        
        setupConstraints()
    }
    
    func customText(sender: UITapGestureRecognizer) {
        let alert = UIAlertController(title: .newEntry, message: .enterText, preferredStyle: UIAlertControllerStyle.alert)
        alert.addTextField { (textField: UITextField) in
            textField.keyboardType = .default
        }
        
        alert.addAction(UIAlertAction.ok(with: alert))
        alert.addAction(UIAlertAction.cancel)
        
        present(alert, animated: true, completion: nil)
    }
    
    func additionalActions(sender: UITapGestureRecognizer) {
        
        let alert = UIAlertController(title: nil, message: nil, preferredStyle: UIAlertControllerStyle.actionSheet)
        alert.addAction(UIAlertAction.send(mail: self))
        alert.addAction(UIAlertAction.clear)
        alert.addAction(UIAlertAction.cancel)
        
        present(alert, animated: true, completion: nil)
    }
    
    func addMarker(sender: UISwipeGestureRecognizer) {
        TinyConsole.addMarker()
    }
    
    // MARK: - Private Methods
    private func setupConstraints() {
        
        consoleTextView.attach(anchors: [.top, .bottom], to: view)
    }
    
    private func addMarkerGesture() {
        let addMarkerGesture = UISwipeGestureRecognizer(target: self, action: #selector(addMarker))
        view.addGestureRecognizer(addMarkerGesture)
    }
    
    private func addCustomTextGesture() {
        let addCustomTextGesture = UITapGestureRecognizer(target: self, action: #selector(customText))
        addCustomTextGesture.numberOfTouchesRequired = 2
        if #available(iOS 9, *) {
            view.addGestureRecognizer(addCustomTextGesture)
        } else {
            consoleTextView.addGestureRecognizer(addCustomTextGesture)
        }
    }
    
    private func addAdditionalActionsGesture() {
        let showAdditionalActionsGesture = UITapGestureRecognizer(target: self, action: #selector(additionalActions))
        showAdditionalActionsGesture.numberOfTouchesRequired = 3
        view.addGestureRecognizer(showAdditionalActionsGesture)
    }
}

// MARK: - MFMailComposeViewControllerDelegate
extension TinyConsoleViewController: MFMailComposeViewControllerDelegate {
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        controller.dismiss(animated: true, completion: nil)
    }
}

// MARK: - UIAlertAction Extensions
fileprivate extension UIAlertAction {
    
    static let cancel: UIAlertAction = {
        UIAlertAction(title: .cancel, style: UIAlertActionStyle.cancel, handler: nil)
    }()
    
    static let clear: UIAlertAction = {
        UIAlertAction(title: .clearConsole, style: UIAlertActionStyle.destructive) {
            (action: UIAlertAction) in
            TinyConsole.clear()
        }
    }()
    
    static func ok(with alert: UIAlertController) -> UIAlertAction {
        return UIAlertAction(title: .addLog, style: UIAlertActionStyle.default) {
            (action: UIAlertAction) in
            if let text = alert.textFields?.first?.text, !text.isEmpty {
                TinyConsole.print(text)
            }
        }
    }
    
    static func send(mail on: UIViewController) -> UIAlertAction {
        return UIAlertAction(title: .sendMail, style: UIAlertActionStyle.default) {
            (action: UIAlertAction) in
            DispatchQueue.main.async {
                if let text = TinyConsole.shared.textView?.text {
                    
                    if MFMailComposeViewController.canSendMail() {
                        
                        let composeViewController = MFMailComposeViewController()
                        
                        composeViewController.mailComposeDelegate = on as? MFMailComposeViewControllerDelegate
                        composeViewController.setSubject(.consoleEmailSubject)
                        composeViewController.setMessageBody(text, isHTML: false)
                        
                        on.present(composeViewController, animated: true, completion: nil)
                        
                    } else {
                        let alert = UIAlertController(title: .accountNotConfigured,
                                                      message: .configureEmailAccount,
                                                      preferredStyle: UIAlertControllerStyle.alert)
                        let okAction = UIAlertAction(title: .ok, style: UIAlertActionStyle.default, handler: nil)
                        alert.addAction(okAction)
                        on.present(alert, animated: true, completion: nil)
                    }
                }
            }
        }
    }
}

// MARK: - UITextView 
fileprivate extension UITextView {
    static let console: UITextView = {
        let textView = UITextView()
        textView.backgroundColor = UIColor.black
        textView.isEditable = false
        return textView
    }()
}

// MARK: - Localization - Actions
fileprivate extension String {
    static let ok = "OK".localized()
    static let cancel = "Cancel".localized()
    static let addLog = "Add log".localized()
    static let clearConsole = "Clear".localized()
    static let sendMail = "Send Email".localized()
}

// MARK: - Localization - New Entry
fileprivate extension String {
    static let newEntry = "New Entry".localized()
    static let enterText = "Enter text you want to log.".localized()
}

// MARK: - Localization - Email
fileprivate extension String {
    static let consoleEmailSubject = "Console Log".localized()
    static let accountNotConfigured = "Account not configured".localized()
    static let configureEmailAccount = "Please configure email account in Mail.app.".localized()
}

