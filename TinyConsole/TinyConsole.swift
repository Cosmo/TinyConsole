//
//  TinyConsole.swift
//  TinyConsole
//
//  Created by Devran Uenal on 28.11.16.
//
//

import UIKit

open class TinyConsole {
    
    // MARK: - Public Properties -
    public static let shared = TinyConsole()
    var textView: UITextView?
    
    // MARK: - Private Accessors -
    private static let textAppearance = [
        NSFontAttributeName: UIFont.menlo(),
        NSForegroundColorAttributeName: UIColor.white
    ]
    
    private lazy var dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateStyle = .none
        formatter.timeStyle = .medium
        return formatter
    }()
    
    var currentTimeStamp: String {
        return dateFormatter.string(from: Date())
    }
    
    // MARK: - Public Methods -
    public static func scrollToBottom() {
        
        guard let
            textView = shared.textView,
            textView.boundsHeightLessThenContentSizeHeight() else { return }
        
        textView.layoutManager.ensureLayout(for: textView.textContainer)
        let offset = CGPoint(x: 0, y: (textView.contentSize.height - textView.frame.size.height))
        textView.setContentOffset(offset, animated: true)
    }
    
    public static func print(_ text: String, color: UIColor = UIColor.white, global: Bool = true) {
        let formattedText = NSMutableAttributedString(string: text)
        
        // set standard text appearance and override foreground color attribute
        formattedText.addAttributes(textAppearance, range: formattedText.range)
        formattedText.addAttribute(NSForegroundColorAttributeName, value: color, range: formattedText.range)
        
        print(formattedText, global: global)
    }
    
    public static func print(_ text: NSAttributedString, global: Bool = true) {
        
        defer { // when we leave this method and global ist true we want to print it to console
            if global {
                Swift.print(text.string)
            }
        }
        
        guard let textView = shared.textView else { return }
        
        let timeStampText = NSMutableAttributedString(string: "\(shared.currentTimeStamp) ")
        
        // set standard text appearance for time-stamp
        timeStampText.addAttributes(textAppearance, range: timeStampText.range)
        
        timeStampText.append(text)
        timeStampText.append(NSAttributedString.break())
        
        let newText = NSMutableAttributedString(attributedString: textView.attributedText)
        newText.append(timeStampText)
        
        DispatchQueue.main.async {
            textView.attributedText = newText
            scrollToBottom()
        }
    }
    
    public static func clear() {
        DispatchQueue.main.async {
            shared.textView?.clear()
            scrollToBottom()
        }
    }
    
    public static func error(_ text: String) {
        print(text, color: UIColor.red)
    }
    
    public static func addMarker() {
        print("-----------", color: UIColor.red)
    }
    
    // MARK: - Private Methods -
    private init() { }
}


private extension UIFont {
    
    static func menlo(with size: CGFloat = 12.0) -> UIFont {
        return UIFont(name: "Menlo", size: size)!
    }
}

private extension NSAttributedString {
    
    static func `break`() -> NSAttributedString {
        return NSAttributedString(string: "\n")
    }
    
    var range: NSRange {
        return NSRange(location: 0, length: length)
    }
}

private extension UITextView {
    
    func clear() {
        text = ""
    }
    
    func boundsHeightLessThenContentSizeHeight() -> Bool {
        return bounds.height < contentSize.height
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
