//
//  UIAlertActionExtensions.swift
//  TinyConsole
//
//  Created by Devran on 30.09.19.
//

import MessageUI

internal extension UIAlertAction {
    static let cancel: UIAlertAction = {
        UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
    }()
    
    static let clear: UIAlertAction = {
        UIAlertAction(title: "Clear", style: .destructive) {
            (action: UIAlertAction) in
            TinyConsole.clear()
        }
    }()
    
    static func okAddLog(with alert: UIAlertController) -> UIAlertAction {
        return UIAlertAction(title: "Add Log", style: .default) {
            (action: UIAlertAction) in
            guard let text = alert.textFields?.first?.text, !text.isEmpty else {
                return
            }
            TinyConsole.print(text)
        }
    }
    
    static func ok() -> UIAlertAction {
        return UIAlertAction(title: "OK", style: .default, handler: nil)
    }
}

internal extension UIAlertAction {
    typealias MailInitiator = UIViewController & MFMailComposeViewControllerDelegate
    
    static func sendMail(on viewController: MailInitiator) -> UIAlertAction {
        UIAlertAction(title: "Send Email", style: .default) {
            (action: UIAlertAction) in
            DispatchQueue.main.async {
                guard let text = TinyConsole.shared.textView?.text else {
                    return
                }
                
                if MFMailComposeViewController.canSendMail() {
                    let composeViewController = MFMailComposeViewController()
                    composeViewController.mailComposeDelegate = viewController
                    composeViewController.setSubject("Console Log")
                    composeViewController.setMessageBody(text, isHTML: false)
                    viewController.present(composeViewController, animated: true, completion: nil)
                } else {
                    let alert = UIAlertController(title: "Email account required",
                                                  message: "Please configure an email account in Mail",
                                                  preferredStyle: .alert)
                    alert.addAction(UIAlertAction.ok())
                    viewController.present(alert, animated: true, completion: nil)
                }
            }
        }
    }
}
