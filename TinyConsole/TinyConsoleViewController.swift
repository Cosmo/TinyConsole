//
//  TinyConsoleViewController.swift
//  TinyConsole
//
//  Created by Devran Uenal on 28.11.16.
//
//

import MessageUI
import UIKit

class TinyConsoleViewController: UIViewController {
    let consoleTextView: UITextView = {
        let textView = UITextView()
        textView.backgroundColor = UIColor.black
        textView.isEditable = false
        return textView
    }()

    open override func viewDidLoad() {
        super.viewDidLoad()
        TinyConsole.shared.textView = consoleTextView
        view.addSubview(consoleTextView)
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

    @objc func customText(sender _: UITapGestureRecognizer) {
        let alert = UIAlertController(title: "Custom Log", message: "Enter text you want to log.", preferredStyle: .alert)
        alert.addTextField { (textField: UITextField) in
            textField.keyboardType = .alphabet
        }

        let okAction = UIAlertAction(title: "Add log", style: .default) {
            (_: UIAlertAction) in
            if let text = alert.textFields?.first?.text, !text.isEmpty {
                TinyConsole.print(text)
            }
        }

        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)

        alert.addAction(okAction)
        alert.addAction(cancelAction)

        present(alert, animated: true, completion: nil)
    }

    func useDefaultGestureConfiguration() {
        if let oldGestureRecognizers = view.gestureRecognizers {
            for gestureRecognizer in oldGestureRecognizers {
                view.removeGestureRecognizer(gestureRecognizer)
            }
        }

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
    }

    @objc func additionalActions(sender _: UITapGestureRecognizer) {

        let alert = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)

        let defaultActions = [
            UIAlertAction(title: "Send Email", style: .default) {
                (_: UIAlertAction) in
                DispatchQueue.main.async {
                    guard let text = TinyConsole.shared.textView?.text else {
                        return
                    }
                    let composeViewController = MFMailComposeViewController()
                    composeViewController.mailComposeDelegate = self
                    composeViewController.setSubject("Console Log")
                    composeViewController.setMessageBody(text, isHTML: false)
                    self.present(composeViewController, animated: true, completion: nil)
                }
            },
            UIAlertAction(title: "Clear", style: .destructive) {
                (_: UIAlertAction) in
                TinyConsole.clear()
            }
        ]
        for action in defaultActions {
            alert.addAction(action)
        }

        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        alert.addAction(cancelAction)

        present(alert, animated: true, completion: nil)
    }

    @objc func addMarker(sender _: UISwipeGestureRecognizer) {
        TinyConsole.addMarker()
    }
}

extension TinyConsoleViewController: MFMailComposeViewControllerDelegate {
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith _: MFMailComposeResult, error _: Error?) {
        controller.dismiss(animated: true, completion: nil)
    }
}
