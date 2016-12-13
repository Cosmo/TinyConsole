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
        let alert = UIAlertController(title: "Custom Log", message: "Enter text you want to log.", preferredStyle: UIAlertControllerStyle.alert)
        alert.addTextField { (textField: UITextField) in
            textField.keyboardType = .alphabet
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
        UIAlertAction(title: "Cancel", style: UIAlertActionStyle.cancel, handler: nil)
    }()
    
    static let clear: UIAlertAction = {
        UIAlertAction(title: "Clear", style: UIAlertActionStyle.destructive) {
            (action: UIAlertAction) in
            TinyConsole.clear()
        }
    }()
    
    static func ok(with alert: UIAlertController) -> UIAlertAction {
        return UIAlertAction(title: "Add log", style: UIAlertActionStyle.default) {
            (action: UIAlertAction) in
            if let text = alert.textFields?.first?.text, !text.isEmpty {
                TinyConsole.print(text)
            }
        }
    }
    
    static func send(mail on: UIViewController) -> UIAlertAction {
        return UIAlertAction(title: "Send Email", style: UIAlertActionStyle.default) {
            (action: UIAlertAction) in
            DispatchQueue.main.async {
                if let text = TinyConsole.shared.textView?.text {
                    
                    if MFMailComposeViewController.canSendMail() {
                        
                        let composeViewController = MFMailComposeViewController()
                        
                        composeViewController.mailComposeDelegate = on as? MFMailComposeViewControllerDelegate
                        composeViewController.setSubject("Console Log")
                        composeViewController.setMessageBody(text, isHTML: false)
                        
                        on.present(composeViewController, animated: true, completion: nil)
                        
                    } else {
                        
                        let alert = UIAlertController(title: "Account not configured",
                                                      message: "Please configure e-mail account in Mail.app",
                                                      preferredStyle: UIAlertControllerStyle.alert)
                        let okAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil)
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
