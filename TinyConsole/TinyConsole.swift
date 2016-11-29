//
//  TinyConsole.swift
//  TinyConsole
//
//  Created by Devran Uenal on 28.11.16.
//
//

import UIKit

open class TinyConsole {
    public static var shared = TinyConsole()
    var textView: UITextView?
    
    init() {
    }
    
    var dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateStyle = DateFormatter.Style.none
        formatter.timeStyle = DateFormatter.Style.medium
        return formatter
    }()
    
    func currentTimeStamp() -> String {
        return self.dateFormatter.string(from: Date())
    }
    
    public func scrollToBottom() {
        if let textView = self.textView, textView.bounds.height < textView.contentSize.height {
            textView.layoutManager.ensureLayout(for: textView.textContainer)
            let offset = CGPoint(x: 0, y: (textView.contentSize.height - textView.frame.size.height))
            textView.setContentOffset(offset, animated: true)
        }
    }
    
    public func print(text: String, global: Bool = true) {
        DispatchQueue.main.async {
            if let textView = self.textView {
                textView.text.append(self.currentTimeStamp() + " " + text + "\n")
                self.scrollToBottom()
            }
            if global {
                Swift.print(text)
            }
        }
    }
    
    public func clear() {
        DispatchQueue.main.async {
            self.textView?.text = ""
            self.scrollToBottom()
        }
    }
    
    public func addMarker() {
        self.print(text: "-----------")
    }
}
