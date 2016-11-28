//
//  TinyConsoleViewController.swift
//  TinyConsole
//
//  Created by Devran Uenal on 28.11.16.
//
//

import UIKit

open class TinyConsoleViewController: UIViewController {
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
        self.setupConstraints()
    }
    
    func setupConstraints() {
        self.consoleTextView.translatesAutoresizingMaskIntoConstraints = false
        self.consoleTextView.topAnchor.constraint(equalTo: self.view.topAnchor).isActive = true
        self.consoleTextView.leftAnchor.constraint(equalTo: self.view.leftAnchor).isActive = true
        self.consoleTextView.rightAnchor.constraint(equalTo: self.view.rightAnchor).isActive = true
        self.consoleTextView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor).isActive = true
    }
}
