<img src="https://raw.githubusercontent.com/Cosmo/TinyConsole/master/TinyConsole-Banner.png" alt=" text" width="100%" />

# TinyConsole

<img src="https://img.shields.io/badge/platform-iOS-blue.svg?style=flat" alt="Platform iOS" /> <img src="https://img.shields.io/badge/swift4.2-compatible-green.svg?style=flat" alt="Swift 4.2 compatible" /> <img src="https://img.shields.io/badge/Carthage-compatible-brightgreen.svg?style=flat" alt="Carthage compatible" /> <img src="https://img.shields.io/badge/license-MIT-blue.svg?style=flat" alt="License MIT" />

TinyConsole is a tiny log console to display information while using your iOS app and written in Swift 4.2.

## Usage

Wrap your Main ViewController inside of a `TinyConsoleController` like so:

```swift
TinyConsole.createViewController(rootViewController: MyMainViewController())
```

### Actions

```swift
// Print message
TinyConsole.print("hello")

// Print messages any color you want 
TinyConsole.print("green text", color: UIColor.green)

// Print a red error message 
TinyConsole.error("something went wrong")

// Print a marker for orientation
TinyConsole.addLine()

// Clear console
TinyConsole.clear()

```

## Implementation Example

Instead of

```swift
func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
    window = UIWindow(frame: UIScreen.main.bounds)
    window?.rootViewController = MyMainViewController()
    window?.makeKeyAndVisible()
    return true
}
```

write

```swift
func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
    window = UIWindow(frame: UIScreen.main.bounds)
    window?.rootViewController = TinyConsole.createViewController(rootViewController: MyMainViewController())
    window?.makeKeyAndVisible()
    return true
}
```

alternatively, check out the example project included in this repository.

## Demo

<img src="https://raw.githubusercontent.com/Cosmo/TinyConsole/master/TinyConsole-Demo.gif" alt=" text" width="25%" />

## Requirements

* Xcode 11
* Swift 5
* iOS 11 or greater

## Installation

### [Carthage](https://github.com/Carthage/Carthage)

Add this to your Cartfile:

```ruby
github "Cosmo/TinyConsole"
```

### Manually

Just drag the source files into your project.

## Hierarchy

<img src="https://raw.githubusercontent.com/Cosmo/TinyConsole/master/TinyConsole-Hierarchy.png" alt=" text" width="100%" />

## Contact

* Devran "Cosmo" Uenal
* Twitter: [@maccosmo](http://twitter.com/maccosmo)

## License

TinyConsole is released under the [MIT License](http://www.opensource.org/licenses/MIT).
