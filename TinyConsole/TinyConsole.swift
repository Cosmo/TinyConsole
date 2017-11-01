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
    var consoleController: TinyConsoleController
    
    public static var textAppearance = [
        NSAttributedStringKey.font: UIFont(name: "Menlo", size: 12.0)!,
        NSAttributedStringKey.foregroundColor: UIColor.white]
    
    private init() {
        consoleController = TinyConsoleController()
    }
    
    var dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateStyle = DateFormatter.Style.none
        formatter.timeStyle = DateFormatter.Style.medium
        return formatter
    }()
    
    func currentTimeStamp() -> String {
        return dateFormatter.string(from: Date())
    }
    
    // MARK: - Create view contoller
    public static func createViewController(rootViewController: UIViewController,
                                            withDefaultGestureConfiguration: Bool = true) -> UIViewController {
        set(rootViewController: rootViewController)
        if withDefaultGestureConfiguration {
            useDefaultGestureConfiguration()
        }
        return shared.consoleController
    }
    
    public static func set(rootViewController: UIViewController) {
        shared.consoleController.rootViewController = rootViewController
    }
    
    public static func scrollToBottom() {
        if let textView = shared.textView, textView.bounds.height < textView.contentSize.height {
            textView.layoutManager.ensureLayout(for: textView.textContainer)
            let offset = CGPoint(x: 0, y: (textView.contentSize.height - textView.frame.size.height))
            textView.setContentOffset(offset, animated: true)
        }
    }
    
    public static func print(_ text: String, color: UIColor = UIColor.white, global: Bool = true) {
        let formattedText = NSMutableAttributedString(string: text)
        let range = NSRange(location: 0, length: formattedText.length)
        
        // set standard text appearance and override foreground color attribute
        formattedText.addAttributes(TinyConsole.textAppearance, range: range)
        formattedText.addAttribute(NSAttributedStringKey.foregroundColor, value: color, range: range)
        
        TinyConsole.print(formattedText, global: global)
    }
    
    public static func print(_ text: NSAttributedString, global: Bool = true) {
        if let textView = shared.textView {
            DispatchQueue.main.async {
                let timeStamped = NSMutableAttributedString(string: shared.currentTimeStamp() + " ")
                let range = NSRange(location: 0, length: timeStamped.length)
                
                // set standard text appearance for time-stamp
                timeStamped.addAttributes(TinyConsole.textAppearance, range: range)
                
                timeStamped.append(text)
                timeStamped.append(NSAttributedString(string: "\n"))
                
                let newText = NSMutableAttributedString(attributedString: textView.attributedText)
                newText.append(timeStamped)
                
                textView.attributedText = newText
                TinyConsole.scrollToBottom()
            }
        }
            
        if global {
            Swift.print(text.string)
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
        TinyConsole.print("-----------", color: UIColor.red)
    }
    
    // MARK: - Configure gesture recognizer
    public static func useDefaultGestureConfiguration() {
        shared.consoleController.consoleViewController.useDefaultGestureConfiguration()
    }
    
    public static func addGestureRecognizer(_ gestureRecognizer: UIGestureRecognizer){
        shared.consoleController.consoleViewController.view.addGestureRecognizer(gestureRecognizer)
    }
    
    public static func removeGestureRecognizer(_ gestureRecognizer: UIGestureRecognizer){
        shared.consoleController.consoleViewController.view.removeGestureRecognizer(gestureRecognizer)
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
