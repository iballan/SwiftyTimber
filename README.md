# SwiftyTimber


## INSTALLATION

### CocoaPods

#### Latest Version:
`pod 'SwiftyTimber'`

OR

`pod 'SwiftyTimber', :git => "https://github.com/iballan/SwiftyTimber.git"`

#### Specific Version:
`pod 'SwiftyTimber', :git => "https://github.com/iballan/SwiftyTimber.git", :tag => "0.0.3"`


## USAGE

Example to plant a tree:
```
#if DEBUG
let timber = Timber.shared.plantTree(TimberDebugTree())
#else
let timber = Timber.shared.plantTree(TimberCrashlyticsTree())
#endif
```

## EXAMPLE

Example to plant a tree for logging to Crashlytics
```
import FirebaseCrashlytics

public class TimberCrashlyticsTree: TimberTree {
    public var shouldPrintLevelNameFor: [TimberLogLevel] = [.error]
    
    public var shouldPrintSystemInfoFor: [TimberLogLevel] = [.error]
    
    public func print(_ item: Any, level: TimberLogLevel?, filename: String, line: Int, column: Int, funcName: String) {
        guard level == .error else { return }
        let sourceName = getSourceFileName(filePath: filename)
        let systemInfo = "[\(sourceName)]:\(line) \(funcName)"
        let message = "\(item)"
        let keysAndValues: [String : Any] = [
            "level" : level?.name ?? "none",
            "filename" : filename,
            "line" : line,
            "column" : column,
            "systemInfo" : systemInfo,
            "message" : message
        ]
        Crashlytics.crashlytics().setCustomKeysAndValues(keysAndValues)
        if item is Error {
            Crashlytics.crashlytics().record(error: item as! Error)
        } else {
            Crashlytics.crashlytics().record(exceptionModel: ExceptionModel(name: "\(sourceName)-\(funcName)", reason: message))
        }
    }
    
    func getSourceFileName(filePath: String) -> String {
        let components = filePath.components(separatedBy: "/")
        return components.last ?? ""
    }
}
```
