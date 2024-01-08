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
    
    private var forest: [TimberTree] = []
    
    
    @discardableResult
    /// Plant tree that will be used for logging. Must implement TimberTree protocol
    /// - Parameter tree: TimberTree
    /// - Returns: self
    public func plant(_ tree: TimberTree) -> Timber {
        forest.append(tree)
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
    public func d(_ message: String, filename: String = #file, line: Int = #line, column: Int = #column, funcName: String = #function) {
        print(message, error: nil, level: .debug, filename: filename, line: line, column: column, funcName: funcName)
    }
    public func d(_ error: Error, _ message: String, filename: String = #file, line: Int = #line, column: Int = #column, funcName: String = #function) {
        print(message, error: error, level: .debug, filename: filename, line: line, column: column, funcName: funcName)
    }
    
    /// Prints item with additional information for **Level.info** type.
    public func i(_ message: String, filename: String = #file, line: Int = #line, column: Int = #column, funcName: String = #function) {
        print(message, error: nil, level: .info, filename: filename, line: line, column: column, funcName: funcName)
    }
    public func i(_ error: Error, _ message: String, filename: String = #file, line: Int = #line, column: Int = #column, funcName: String = #function) {
        print(message, error: error, level: .info, filename: filename, line: line, column: column, funcName: funcName)
    }
    
    /// Prints item with additional information for **Level.warning** type.
    public func w(_ message: String, filename: String = #file, line: Int = #line, column: Int = #column, funcName: String = #function) {
        print(message, error: nil, level: .warning, filename: filename, line: line, column: column, funcName: funcName)
    }
    public func w(_ error: Error, _ message: String, filename: String = #file, line: Int = #line, column: Int = #column, funcName: String = #function) {
        print(message, error: error, level: .warning, filename: filename, line: line, column: column, funcName: funcName)
    }
    
    /// Prints item with additional information for **Level.error** type.
    public func e(_ error: Error, _ message : String, filename: String = #file, line: Int = #line, column: Int = #column, funcName: String = #function) {
        print(message, error: error, level: .error, filename: filename, line: line, column: column, funcName: funcName)
    }
    public func e(_ message : String, filename: String = #file, line: Int = #line, column: Int = #column, funcName: String = #function) {
        print(message, error: nil, level: .error, filename: filename, line: line, column: column, funcName: funcName)
    }
    
    /// Prints item itself without any additional information.
    public func none(_ item: Any, filename: String = #file, line: Int = #line, column: Int = #column, funcName: String = #function) {
        print("\(item)", error: nil, level: nil, filename: filename, line: line, column: column, funcName: funcName)
    }
    
    // MARK: Private methods
    private func print(_ message: String, error: Error?, level: TimberLogLevel?, filename: String, line: Int, column: Int, funcName: String) {
        forest.forEach { tree in
            tree.print(message, error: error, level: level, filename: filename, line: line, column: column, funcName: funcName)
        }
    }
}
