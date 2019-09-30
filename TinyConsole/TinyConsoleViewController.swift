//
//  TinyConsoleViewController.swift
//  TinyConsole
//
//  Created by Devran Uenal on 28.11.16.
//
//

import UIKit
import MessageUI

/// This UIViewController
class TinyConsoleViewController: UIViewController {
    let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.alignment = .fill
        stackView.spacing = 4
        return stackView
    }()
    
    private let consoleTextView = UITextView.console

    open override func viewDidLoad() {
        super.viewDidLoad()
        TinyConsole.shared.textView = consoleTextView
        view.addSubview(consoleTextView)
        view.addSubview(stackView)
        setupConstraints()
        
        let customTextButton = UIButton(type: .system)
        customTextButton.setTitle("Text", for: .normal)
        customTextButton.addTarget(self, action: #selector(customText(sender:)), for: .touchUpInside)
        customTextButton.applyMiniStyle()
        stackView.addArrangedSubview(customTextButton)
        
        let lineButton = UIButton(type: .system)
        lineButton.setTitle("Line", for: .normal)
        lineButton.addTarget(self, action: #selector(addLine(sender:)), for: .touchUpInside)
        lineButton.applyMiniStyle()
        stackView.addArrangedSubview(lineButton)
        
        let clearButton = UIButton(type: .system)
        clearButton.setTitle("More", for: .normal)
        clearButton.addTarget(self, action: #selector(additionalActions(sender:)), for: .touchUpInside)
        clearButton.applyMiniStyle()
        stackView.addArrangedSubview(clearButton)
    }

    private func setupConstraints() {
        consoleTextView.translatesAutoresizingMaskIntoConstraints = false
        consoleTextView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        consoleTextView.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor).isActive = true
        view.safeAreaLayoutGuide.rightAnchor.constraint(equalTo: consoleTextView.rightAnchor).isActive = true
        view.bottomAnchor.constraint(equalTo: consoleTextView.bottomAnchor).isActive = true
        
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.topAnchor.constraint(equalTo: view.topAnchor, constant: 8).isActive = true
        view.safeAreaLayoutGuide.rightAnchor.constraint(equalTo: stackView.rightAnchor, constant: 8).isActive = true
    }

    @objc func customText(sender: AnyObject) {
        let alert = UIAlertController(title: "Custom Log", message: "Enter text you want to log.", preferredStyle: .alert)
        alert.addTextField { $0.keyboardType = .default }
        alert.addAction(.okAddLog(with: alert))
        alert.addAction(.cancel)
        present(alert, animated: true, completion: nil)
    }

    @objc func additionalActions(sender: AnyObject) {
        let alert = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        alert.addAction(.sendMail(on: self))
        alert.addAction(.clear)
        alert.addAction(.cancel)
        present(alert, animated: true, completion: nil)
    }

    @objc func addLine(sender: AnyObject) {
        TinyConsole.addLine()
    }
}

extension TinyConsoleViewController: MFMailComposeViewControllerDelegate {
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        controller.dismiss(animated: true, completion: nil)
    }
}
