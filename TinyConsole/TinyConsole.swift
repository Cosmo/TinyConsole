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
    
    public static func scrollToBottom() {
        if let textView = shared.textView, textView.bounds.height < textView.contentSize.height {
            textView.layoutManager.ensureLayout(for: textView.textContainer)
            let offset = CGPoint(x: 0, y: (textView.contentSize.height - textView.frame.size.height))
            textView.setContentOffset(offset, animated: true)
        }
    }
    
    public static func print(_ text: String, global: Bool = true, color : UIColor = UIColor.white) {
        
        let formattedText = NSMutableAttributedString(string: text)
        let range = NSRange(location: 0, length: formattedText.length)
        
        // set text font and color
        formattedText.addAttribute(NSForegroundColorAttributeName, value: color, range: range)
        if let font = UIFont(name: "Menlo", size: 12.0){
            formattedText.addAttribute(NSFontAttributeName, value: font, range: range)
        }
        
        TinyConsole.print(formattedText, global: global)
    }
    
    public static func print(_ text: NSAttributedString, global : Bool = true) {
        DispatchQueue.main.async {
            if let textView = shared.textView {
                let timeStamped = NSMutableAttributedString(string: shared.currentTimeStamp() + " ")
                let range = NSRange(location: 0, length: timeStamped.length)
                
                // set time-stamp font and color
                if let font = UIFont(name: "Menlo", size: 12.0){
                    timeStamped.addAttribute(NSFontAttributeName, value: font, range: range)
                }
                timeStamped.addAttribute(NSForegroundColorAttributeName, value: UIColor.white, range: range)
            
                timeStamped.append(text)
                timeStamped.append(NSAttributedString(string :"\n"))
                
                let newText = NSMutableAttributedString(attributedString: textView.attributedText)
                newText.append(timeStamped)
                
                textView.attributedText = newText
                TinyConsole.scrollToBottom()
            }
            if global {
                Swift.print(text.string)
            }
        }
    }
    
    public static func clear() {
        DispatchQueue.main.async {
            shared.textView?.text = ""
            TinyConsole.scrollToBottom()
        }
    }
    
    public static func error(_ text: String) {
        TinyConsole.print(text, color: UIColor.red)
    }
    
    public static func addMarker() {
        TinyConsole.print("-----------")
    }
}

// deprecated functions
extension TinyConsole {
    @available(*,deprecated, message: "use static function TinyConsole.scrollToBottom() instead")
    public func scrollToBottom() {
        TinyConsole.scrollToBottom()
    }
    
    @available(*,deprecated, message: "use static function TinyConsole.print(_:, global:) instead")
    public func print(text: String, global: Bool = true) {
        TinyConsole.print(text, global: global)
    }
    
    @available(*,deprecated, message: "use static function TinyConsole.clear() instead")
    public func clear() {
        TinyConsole.clear()
    }
    
    @available(*, deprecated, message: "use static function TinyConsole.addMarker() instead")
    public func addMarker() {
        TinyConsole.addMarker()
    }
}
