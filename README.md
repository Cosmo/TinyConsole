<img src="https://raw.githubusercontent.com/Cosmo/TinyConsole/master/TinyConsole-Banner.png" alt=" text" width="100%" />

# TinyConsole

<img src="https://img.shields.io/badge/platform-iOS-blue.svg?style=flat" alt="Platform iOS" />
<img src="https://img.shields.io/badge/swift3-compatible-green.svg?style=flat" alt="Swift 3 compatible" />
<img src="https://img.shields.io/badge/Carthage-compatible-brightgreen.svg?style=flat" alt="Carthage compatible" />
<img src="https://img.shields.io/badge/license-MIT-blue.svg?style=flat" alt="License MIT" />

A tiny log console to display information while using your iOS app.
Written in Swift 3.

<img src="https://raw.githubusercontent.com/Cosmo/TinyConsole/master/TinyConsole-Open.png" alt=" text" width="50%" />

## Usage

Create a `TinyConsoleController`-Instance and pass your App-ViewController as a `rootViewController` parameter.

```swift
TinyConsoleController(rootViewController: MyMainViewController())
```

### Actions

```swift
// prints Formatted or non-formatted strings
TinyConsole.print("hello")

// prints a red error message 
TinyConsole.error("something went wrong")

// print messages any color you want 
TinyConsole.print("Green text", color: UIColor.green)

TinyConsole.addMarker()
TinyConsole.clear()
```

### Gestures

* Swipe from Left to Right: `Add marker`
* 2 Finger Tap: `Add custom log entry`
* 3 Finger Tap: Show Action Sheet to `Clear Console` and `Send Mail`
* Shake to toggle the console view. If you’re using the Simulator, press <kbd>⌃ ctrl</kbd>-<kbd>⌘ cmd</kbd>-<kbd>z</kbd>.


## Implementation Example

Instead of

```swift
func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
    self.window = UIWindow(frame: UIScreen.main.bounds)
    self.window?.rootViewController = MainViewController()
    self.window?.makeKeyAndVisible()
    return true
}
```

write

```swift
func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
    self.window = UIWindow(frame: UIScreen.main.bounds)
    self.window?.rootViewController = TinyConsoleController(rootViewController: MainViewController())
    self.window?.makeKeyAndVisible()
    return true
}
```

or checkout the example project included in this repository.

## Demo

<img src="https://raw.githubusercontent.com/Cosmo/TinyConsole/master/TinyConsole-Demo.gif" alt=" text" width="25%" />

## Installation

### [Carthage](https://github.com/Carthage/Carthage)

Add this to your Cartfile:

```ruby
github "Cosmo/TinyConsole"
```

### [Cocoapods](https://cocoapods.org)

Add this to your Podfile:

```ruby
pod 'TinyConsole'
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
