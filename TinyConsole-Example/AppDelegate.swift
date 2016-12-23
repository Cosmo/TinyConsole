//
//  AppDelegate.swift
//  TinyConsole-Example
//
//  Created by Devran Uenal on 28.11.16.
//
//

import UIKit
import TinyConsole

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate, TinyConsoleThreeTapDelegate {
    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        window = UIWindow(frame: UIScreen.main.bounds)
        
        let viewController = UINavigationController(rootViewController: MainViewController())
        viewController.title = "Main"
        viewController.tabBarItem = UITabBarItem(tabBarSystemItem: UITabBarSystemItem.recents, tag: 0)
        
        let tabBarController = UITabBarController()
        tabBarController.viewControllers = [
            viewController
        ]
        
        window?.rootViewController = TinyConsoleController(rootViewController: tabBarController)
        window?.makeKeyAndVisible()
        
        // Add custom 3 finger tap delegate
        TinyConsole.threeTapDelegate = self
        
        return true
    }
    
    // MARK: - TinyConsoleThreeTapDelegate
    var isWithDefaultActions: Bool = true
    var numberOfAdditionalActions: Int = 3
    func actionTitle(atIndex index: Int) -> String {
        return "Custom Action #\(index)"
    }
    func actionStyle(atIndex index: Int) -> UIAlertActionStyle {
        return .default
    }
    func actionHandler(atIndex index: Int) -> ((UIAlertAction) -> Void)? {
        return { _ in
            let randomColor = UIColor(red: CGFloat(arc4random())/CGFloat(UINT32_MAX), green: CGFloat(arc4random())/CGFloat(UINT32_MAX), blue: CGFloat(arc4random())/CGFloat(UINT32_MAX), alpha: 0.8)
            TinyConsole.print("custom action #\(index)", color: randomColor, global: true)
        }
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}

