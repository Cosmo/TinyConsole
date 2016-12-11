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
        textView.isEditable = false
        return textView
    }()
    
    override open func viewDidLoad() {
        super.viewDidLoad()
        TinyConsole.shared.textView = consoleTextView
        view.addSubview(consoleTextView)
        
        let addMarkerGesture = UISwipeGestureRecognizer(target: self, action: #selector(addMarker))
        view.addGestureRecognizer(addMarkerGesture)
        
        let addCustomTextGesture = UITapGestureRecognizer(target: self, action: #selector(customText))
        addCustomTextGesture.numberOfTouchesRequired = 2
        if #available(iOS 9, *) {
            view.addGestureRecognizer(addCustomTextGesture)
        } else {
            consoleTextView.addGestureRecognizer(addCustomTextGesture)
        }
        
        let showAdditionalActionsGesture = UITapGestureRecognizer(target: self, action: #selector(additionalActions))
        showAdditionalActionsGesture.numberOfTouchesRequired = 3
        view.addGestureRecognizer(showAdditionalActionsGesture)
        
        setupConstraints()
    }
    
    func setupConstraints() {
        consoleTextView.translatesAutoresizingMaskIntoConstraints = false
        if #available(iOS 9, *) {
            consoleTextView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
            consoleTextView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
            consoleTextView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
            consoleTextView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        } else {
            NSLayoutConstraint(item: consoleTextView, attribute: .top, relatedBy: .equal, toItem: view, attribute: .top, multiplier: 1.0, constant: 0).isActive = true
            NSLayoutConstraint(item: consoleTextView, attribute: .left, relatedBy: .equal, toItem: view, attribute: .left, multiplier: 1.0, constant: 0).isActive = true
            NSLayoutConstraint(item: consoleTextView, attribute: .right, relatedBy: .equal, toItem: view, attribute: .right, multiplier: 1.0, constant: 0).isActive = true
            NSLayoutConstraint(item: consoleTextView, attribute: .bottom, relatedBy: .equal, toItem: view, attribute: .bottom, multiplier: 1.0, constant: 0).isActive = true
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
        
        present(alert, animated: true, completion: nil)
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
        
        present(alert, animated: true, completion: nil)
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
