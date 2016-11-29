<img src="https://raw.githubusercontent.com/Cosmo/TinyConsole/master/TinyConsole-Banner.png" alt=" text" width="100%" />

# TinyConsole

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
TinyConsole.shared.print(text: "hello")
TinyConsole.shared.addMarker()
TinyConsole.shared.clear()
```

### Gestures

* Swipe from Left to Right: `Add marker`
* 2 Finger Tap: `Add custom log entry`
* 3 Finger Tap: Show Action Sheet to `Clear Console` and `Send Mail`

> Shake to toggle the console view. If you’re using the Simulator, press <kbd>⌃ ctrl</kbd>-<kbd>⌘ cmd</kbd>-<kbd>z</kbd>.


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

# Hierarchy

<img src="https://raw.githubusercontent.com/Cosmo/TinyConsole/master/TinyConsole-Hierarchy.png" alt=" text" width="100%" />

# Contact

* Devran "Cosmo" Uenal
* Twitter: [@maccosmo](http://twitter.com/maccosmo)
