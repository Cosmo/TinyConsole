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
    
    public static func scrollToBottom(){
        if let textView = shared.textView, textView.bounds.height < textView.contentSize.height {
            textView.layoutManager.ensureLayout(for: textView.textContainer)
            let offset = CGPoint(x: 0, y: (textView.contentSize.height - textView.frame.size.height))
            textView.setContentOffset(offset, animated: true)
        }
    }
    
    public static func print(_ text: String, global: Bool = true){
        DispatchQueue.main.async {
            if let textView = shared.textView {
                textView.text.append(shared.currentTimeStamp() + " " + text + "\n")
                TinyConsole.scrollToBottom()
            }
            if global {
                Swift.print(text)
            }
        }
    }
    
    public static func clear() {
        DispatchQueue.main.async {
            shared.textView?.text = ""
            TinyConsole.scrollToBottom()
        }
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
