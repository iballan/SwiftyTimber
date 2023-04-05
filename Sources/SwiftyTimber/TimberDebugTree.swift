//
//  TimberDebugTree.swift
//  SwiftyTimber
//
//  Created by mbh on 16/3/23.
//

import Foundation

public class TimberDebugTree: TimberTree {
    /// An array of level for the logger to print name.
    ///
    /// Default value is `Level.allCases`.
    public var shouldPrintDateFor = TimberLogLevel.allCases
    /// An array of levels for the logger to print an emoji.
    ///
    /// Default value is `Level.allCases`.
    public var shouldPrintEmojiFor = TimberLogLevel.allCases
    /// An array of levels for the logger to print Level name.
    ///
    /// Default value is `Level.allCases`.
    public var shouldPrintLevelNameFor = TimberLogLevel.allCases
    /// An array of levels for the logger to print extra info like file name, line number, etc.
    ///
    /// Default value is `[.warning, .error]`.
    public var shouldPrintSystemInfoFor: [TimberLogLevel] = [.warning, .error]
    /// A dictionary contains an emoji that overrides default emoji for the level.
    ///
    /// Default value is `[:]`.
    public var levelEmojis: [TimberLogLevel: String] = [:]
    /// Determines the format of printing time for each of the logs.
    ///
    /// Default value is `yyyy-MM-dd HH:mm:ss`
    public var dateFormat = "yyyy-MM-dd HH:mm:ss"
    
    public init() {}
    
    private func getDateDescription() -> String {
        return dateFormatter.string(from: Date())
    }
    
    private func getEmojiFor(_ level: TimberLogLevel) -> String {
        return levelEmojis[level] ?? level.emoji
    }
    
    private lazy var dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = dateFormat
        formatter.locale = Locale.current
        formatter.timeZone = TimeZone.current
        return formatter
    }()
    
    public func print(_ message: String, error: Error?, level: TimberLogLevel?, filename: String, line: Int, column: Int, funcName: String) {
#if DEBUG
        var stringToPrint = ""
        if let level = level {
            if shouldPrintDateFor.contains(level) { stringToPrint.append(getDateDescription(), withSeparator: true) }
            if shouldPrintEmojiFor.contains(level) { stringToPrint.append(getEmojiFor(level), withSeparator: true) }
            if shouldPrintLevelNameFor.contains(level) { stringToPrint.append(level.name, withSeparator: true) }
            if shouldPrintSystemInfoFor.contains(level) {
                let systemInfo = "[\(getSourceFileName(filePath: filename))]:\(line) \(funcName) ->"
                stringToPrint.append(systemInfo, withSeparator: true)
            }
        }
        if !message.isEmpty || error == nil {
            stringToPrint.append(message, withSeparator: true)
        }
        if let error = error {
            stringToPrint.append(String(describing: error), withSeparator: true)
        }
        Swift.print(stringToPrint)
#endif
    }
    
    func getSourceFileName(filePath: String) -> String {
        let components = filePath.components(separatedBy: "/")
        return components.last ?? ""
    }
}

extension String {
    mutating func append(_ other: String, withSeparator: Bool, separator: String = " ") {
        self.append(withSeparator ? (self.isEmpty ? other : separator + other) : other)
    }
}
