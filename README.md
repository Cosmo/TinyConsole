# TinyConsole

A tiny log console to display information while using your iOS app.

## Usage

Set your ViewController as a `rootViewController` of a `TinyConsoleController`-Instance.

```swift
TinyConsoleController(rootViewController: MyMainViewController())
```

### Actions

```swift
TinyConsole.shared.print(text: “hello”)
TinyConsole.shared.addMarker()
TinyConsole.shared.clear()
```

> Shake to toggle the console view. If you're using the Simulator, press <kbd>⌃ ctrl</kbd>-<kbd>⌘ cmd</kbd>-<kbd>z</kbd>.


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
