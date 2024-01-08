# SwiftyTimber

SwiftyTimber is another Logging library forked from [PureLogger](https://github.com/Kharauzov/PureLogger) and inspired by [Timber](https://github.com/JakeWharton/timber)

The main goals of this library are:
* Log freely without worring about production
* Easily read logged messages in the debug console
* Log errors to Crashlytics (Or similar crash report system)

## INSTALLATION

### CocoaPods

##### Latest Version:
`pod 'SwiftyTimber'`

##### OR

`pod 'SwiftyTimber', :git => "https://github.com/iballan/SwiftyTimber.git"`

##### Specific Version:
`pod 'SwiftyTimber', :git => "https://github.com/iballan/SwiftyTimber.git", :tag => "0.1.0"`

### Swift Package Manager

Once you have your Swift package set up, adding SwiftyTimber as a dependency is as easy as adding it to the dependencies value of your Package.swift.

```swift
dependencies: [
    .package(url: "https://github.com/iballan/SwiftyTimber.git", .upToNextMajor(from: "0.1.0"))
]
```


## USAGE

Example to plant a tree:
```swift
// Static methods
#import SwiftyTimber
#if DEBUG
Timber.shared.plant(TimberDebugTree())
#else
Timber.shared.plant(TimberCrashlyticsTree())
#endif

// Then in your code
#import SwiftyTimber
Timber.i("This is info log")
Timber.d("This is debug log")
Timber.e("This is error log", error)
```
### Or what I prefer:

```swift
#import SwiftyTimber
#if DEBUG
let logger = Timber.shared.plant(TimberDebugTree())
#else
let logger = Timber.shared.plant(TimberCrashlyticsTree()).plant(AnotherTree())
#endif

// Then in your code
logger.i("This is info log")
logger.d("This is debug log")
logger.e("This is error log", error)
```
## EXAMPLE

Example to plant a tree for logging to Crashlytics
```swift
import FirebaseCrashlytics

public class TimberCrashlyticsTree: TimberTree {
    public func print(_ message: String, _ error: Error?, level: TimberLogLevel?, filename: String, line: Int, column: Int, funcName: String) {
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
        if let error = error {
            Crashlytics.crashlytics().record(error: error)
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
