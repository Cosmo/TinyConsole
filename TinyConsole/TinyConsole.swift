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
    
    static var textAppearance: [NSAttributedString.Key: Any] = {
        return [
            .font: UIFont(name: "Menlo", size: 12.0),
            .foregroundColor: UIColor.white
        ].compactMapValues({ $0 })
    }()

    private init() {
        consoleController = TinyConsoleController()
    }

    private lazy var dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateStyle = .none
        formatter.timeStyle = .medium
        return formatter
    }()

    var currentTimeStamp: String {
        return dateFormatter.string(from: Date())
    }

    // MARK: - Create view contoller
    public static func createViewController(rootViewController: UIViewController) -> UIViewController {
        set(rootViewController: rootViewController)
        return shared.consoleController
    }

    public static func set(rootViewController: UIViewController) {
        shared.consoleController.rootViewController = rootViewController
    }

    public static func scrollToBottom() {
        guard let
            textView = shared.textView,
            textView.boundsHeightLessThenContentSizeHeight() else { return }
        
        textView.layoutManager.ensureLayout(for: textView.textContainer)
        let offset = CGPoint(x: 0, y: (textView.contentSize.height - textView.frame.size.height))
        textView.setContentOffset(offset, animated: true)
    }
    
    public static func toggleWindowMode() {
        DispatchQueue.main.async {
            shared.consoleController.toggleWindowMode()
        }
    }

    public static func print(_ text: String, color: UIColor = UIColor.white, global: Bool = true) {
        let formattedText = NSMutableAttributedString(string: text)
        formattedText.addAttributes(textAppearance, range: formattedText.range)
        formattedText.addAttribute(.foregroundColor, value: color, range: formattedText.range)

        print(formattedText, global: global)
    }

    public static func print(_ text: NSAttributedString, global: Bool = true) {
        // When we leave this method and global is true, we want to print it to console
        defer {
            if global {
                Swift.print(text.string)
            }
        }
        
        guard let textView = shared.textView else { return }
        
        DispatchQueue.main.async {
            let timeStamped = NSMutableAttributedString(string: "\(shared.currentTimeStamp) ")
            let range = NSRange(location: 0, length: timeStamped.length)
            
            timeStamped.addAttributes(textAppearance, range: range)
            timeStamped.append(text)
            timeStamped.append(.breakLine())
            
            let newText = NSMutableAttributedString(attributedString: textView.attributedText)
            newText.append(timeStamped)
            
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

    public static func addLine() {
        print("-----------", color: UIColor.red)
    }
    
    public static func setHeight(height: CGFloat) {
        shared.consoleController.consoleHeight = height
    }
}
