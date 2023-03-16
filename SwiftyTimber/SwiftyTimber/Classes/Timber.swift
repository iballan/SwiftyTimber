//
//  Timber.swift
//  SwiftyTimber
//
//  Created by mbh on 16/3/23.
//

public enum TimberLogLevel: Int, CaseIterable {
    case debug, info, warning, error
    
    public var emoji: String {
        switch self {
        case .debug: return "✏️"
        case .info: return "ℹ️"
        case .warning: return "⚠️"
        case .error: return "❌"
        }
    }
    
    public var name: String {
        switch self {
        case .debug: return "DEBUG"
        case .info: return "INFO"
        case .warning: return "WARNING"
        case .error: return "ERROR"
        }
    }
}

/// Maybe the best logger in the world :P :D
public class Timber {
    
    // MARK: Public properties
    /// The global instance of the logger to use across the project.
    ///
    /// For local usage please create a separate instance of the logger.
    public static var shared = Timber()
    
    private var tree: TimberTree?
    
    
    @discardableResult
    /// Plant tree that will be used for logging. Must implement TimberTree protocol
    /// - Parameter tree: TimberTree
    /// - Returns: self
    public func plantTree(_ tree: TimberTree) -> Timber {
        self.tree = tree
        return self
    }
    
    // MARK: Public methods
    
    public init() { }
    
    /// To be able to print anything shortly
    @discardableResult
    public convenience init(_ items: Any) {
        self.init()
        none(items)
    }
    
    /// Prints item with additional information for **Level.debug** type.
    public func debug(_ item: Any, filename: String = #file, line: Int = #line, column: Int = #column, funcName: String = #function) {
        print(item, level: .debug, filename: filename, line: line, column: column, funcName: funcName)
    }
    
    /// Prints item with additional information for **Level.info** type.
    public func info(_ item: Any, filename: String = #file, line: Int = #line, column: Int = #column, funcName: String = #function) {
        print(item, level: .info, filename: filename, line: line, column: column, funcName: funcName)
    }
    
    /// Prints item with additional information for **Level.warning** type.
    public func warning(_ item: Any, filename: String = #file, line: Int = #line, column: Int = #column, funcName: String = #function) {
        print(item, level: .warning, filename: filename, line: line, column: column, funcName: funcName)
    }
    
    /// Prints item with additional information for **Level.error** type.
    public func error(_ item: Any, filename: String = #file, line: Int = #line, column: Int = #column, funcName: String = #function) {
        print(item, level: .error, filename: filename, line: line, column: column, funcName: funcName)
    }
    
    /// Prints item itself without any additional information.
    public func none(_ item: Any, filename: String = #file, line: Int = #line, column: Int = #column, funcName: String = #function) {
        print(item, level: nil, filename: filename, line: line, column: column, funcName: funcName)
    }
    
    // MARK: Private methods
    private func print(_ item: Any, level: TimberLogLevel?, filename: String, line: Int, column: Int, funcName: String) {
        tree?.print(item, level: level, filename: filename, line: line, column: column, funcName: funcName)
    }
}
