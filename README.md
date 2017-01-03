<img src="https://raw.githubusercontent.com/Cosmo/TinyConsole/master/TinyConsole-Banner.png" alt=" text" width="100%" />

# TinyConsole

<img src="https://img.shields.io/badge/platform-iOS-blue.svg?style=flat" alt="Platform iOS" />
<img src="https://img.shields.io/badge/swift3-compatible-green.svg?style=flat" alt="Swift 3 compatible" />
<img src="https://img.shields.io/badge/Carthage-compatible-brightgreen.svg?style=flat" alt="Carthage compatible" />
<img src="https://img.shields.io/badge/license-MIT-blue.svg?style=flat" alt="License MIT" />

A tiny log console to display information while using your iOS app.
Written in Swift 3.

## Usage

Pass your App-ViewController as a `rootViewController` parameter to `TinyConsole` to create the `TinyConsoleController`.

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
TinyConsole.addMarker()

// Clear console
TinyConsole.clear()

// Set root view controller
TinyConsole.set(rootViewController: MyViewController())
```
> Calling `TinyConsole.set(rootViewController:)` will change the `rootViewController` of `TinyConsoleController` but hold the console content and gesture configurations, which means the text and gesture recognizers of the console view will remain the same.

### Gestures

By default, the gestures is configured as follows:

* Swipe from Left to Right: `Add marker`
* 2 Finger Tap: `Add custom log entry`
* 3 Finger Tap: Show Action Sheet to `Clear Console` and `Send Mail`
* Shake to toggle the console view. If you’re using the Simulator, press <kbd>⌃ ctrl</kbd>-<kbd>⌘ cmd</kbd>-<kbd>z</kbd>.

To customize the gestures, specify `withDefaultGestureConfiguration` as `false`

```swift
TinyConsole.createViewController(rootViewController: MyMainViewController(), withDefaultGestureConfiguration: false)

```

and add your own gesture recognizers

```swift
let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(consoleTapped))
TinyConsole.addGestureRecognizer(tapGestureRecognizer)
```

> Calling `TinyConsole.useDefaultGestureConfiguration()` will remove all gesture recognizers from console view and add the default gesture recognizers.

## Implementation Example

Instead of

```swift
func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
    window = UIWindow(frame: UIScreen.main.bounds)
    window?.rootViewController = MainViewController()
    window?.makeKeyAndVisible()
    return true
}
```

write

```swift
func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
    window = UIWindow(frame: UIScreen.main.bounds)
    window?.rootViewController = TinyConsole.createViewController(rootViewController: MyMainViewController())
    window?.makeKeyAndVisible()
    return true
}
```

or checkout the example project included in this repository.

## Demo

<img src="https://raw.githubusercontent.com/Cosmo/TinyConsole/master/TinyConsole-Demo.gif" alt=" text" width="25%" />

## Requirements

* Xcode 8
* Swift 3
* iOS 8 or greater

## Installation

### [Carthage](https://github.com/Carthage/Carthage)

Add this to your Cartfile:

```ruby
github "Cosmo/TinyConsole"
```

### [CocoaPods](https://cocoapods.org)

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
