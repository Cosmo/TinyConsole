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
    let consoleTextView: UITextView = {
        let textView = UITextView()
        textView.backgroundColor = UIColor.black
        textView.textColor = UIColor.white
        textView.font = UIFont(name: "Menlo", size: 12.0)
        textView.isEditable = false
        return textView
    }()
    
    override open func viewDidLoad() {
        super.viewDidLoad()
        TinyConsole.shared.textView = self.consoleTextView
        self.view.addSubview(self.consoleTextView)
        
        let addMarkerGesture = UISwipeGestureRecognizer(target: self, action: #selector(addMarker))
        self.view.addGestureRecognizer(addMarkerGesture)
        
        let addCustomTextGesture = UITapGestureRecognizer(target: self, action: #selector(customText))
        addCustomTextGesture.numberOfTouchesRequired = 2
        self.view.addGestureRecognizer(addCustomTextGesture)
        
        let showAdditionalActionsGesture = UITapGestureRecognizer(target: self, action: #selector(additionalActions))
        showAdditionalActionsGesture.numberOfTouchesRequired = 3
        self.view.addGestureRecognizer(showAdditionalActionsGesture)
        
        self.setupConstraints()
    }
    
    func setupConstraints() {
        self.consoleTextView.translatesAutoresizingMaskIntoConstraints = false
        if #available(iOS 9, *) {
            self.consoleTextView.topAnchor.constraint(equalTo: self.view.topAnchor).isActive = true
            self.consoleTextView.leftAnchor.constraint(equalTo: self.view.leftAnchor).isActive = true
            self.consoleTextView.rightAnchor.constraint(equalTo: self.view.rightAnchor).isActive = true
            self.consoleTextView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor).isActive = true
        } else {
            NSLayoutConstraint(item: self.consoleTextView, attribute: .top, relatedBy: .equal, toItem: self.view, attribute: .top, multiplier: 1.0, constant: 0).isActive = true
            NSLayoutConstraint(item: self.consoleTextView, attribute: .left, relatedBy: .equal, toItem: self.view, attribute: .left, multiplier: 1.0, constant: 0).isActive = true
            NSLayoutConstraint(item: self.consoleTextView, attribute: .right, relatedBy: .equal, toItem: self.view, attribute: .right, multiplier: 1.0, constant: 0).isActive = true
            NSLayoutConstraint(item: self.consoleTextView, attribute: .bottom, relatedBy: .equal, toItem: self.view, attribute: .bottom, multiplier: 1.0, constant: 0).isActive = true
        }
    }
    
    func customText(sender: UITapGestureRecognizer) {
        let alert = UIAlertController(title: "Custom Log", message: "Enter text you want to log.", preferredStyle: UIAlertControllerStyle.alert)
        alert.addTextField { (textField: UITextField) in
            textField.keyboardType = .alphabet
        }
        
        let okAction = UIAlertAction(title: "Add log", style: UIAlertActionStyle.default) {
            (action: UIAlertAction) in
            if let text = alert.textFields?.first?.text, !text.isEmpty {
                TinyConsole.print(text)
            }
        }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: UIAlertActionStyle.cancel, handler: nil)
        
        alert.addAction(okAction)
        alert.addAction(cancelAction)
        
        self.present(alert, animated: true, completion: nil)
    }
    
    func additionalActions(sender: UITapGestureRecognizer) {
        let alert = UIAlertController(title: nil, message: nil, preferredStyle: UIAlertControllerStyle.actionSheet)
        
        let sendMail = UIAlertAction(title: "Send Email", style: UIAlertActionStyle.default) {
            (action: UIAlertAction) in
            DispatchQueue.main.async {
                if let text = TinyConsole.shared.textView?.text {
                    let composeViewController = MFMailComposeViewController()
                    composeViewController.mailComposeDelegate = self
                    composeViewController.setSubject("Console Log")
                    composeViewController.setMessageBody(text, isHTML: false)
                    self.present(composeViewController, animated: true, completion: nil)
                }
            }
        }
        
        let clearAction = UIAlertAction(title: "Clear", style: UIAlertActionStyle.destructive) {
            (action: UIAlertAction) in
            TinyConsole.clear()
        }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: UIAlertActionStyle.cancel, handler: nil)
        
        alert.addAction(sendMail)
        alert.addAction(clearAction)
        alert.addAction(cancelAction)
        
        self.present(alert, animated: true, completion: nil)
    }
    
    func addMarker(sender: UISwipeGestureRecognizer) {
        TinyConsole.addMarker()
    }
}

extension TinyConsoleViewController: MFMailComposeViewControllerDelegate {
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        controller.dismiss(animated: true, completion: nil)
    }
}
