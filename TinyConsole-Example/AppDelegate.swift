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
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        window = UIWindow(frame: UIScreen.main.bounds)
        
        let viewController = UINavigationController(rootViewController: MainViewController())
        viewController.title = "Main"
        viewController.tabBarItem = UITabBarItem(tabBarSystemItem: UITabBarItem.SystemItem.recents, tag: 0)
        
        let tabBarController = UITabBarController()
        tabBarController.viewControllers = [
            viewController
        ]
        
        // deprecated
        // window?.rootViewController = TinyConsoleController(rootViewController: tabBarController)
        
        
        
        // TinyConsole with default gesture recognizers
        // window?.rootViewController = TinyConsole.createViewController(rootViewController: tabBarController)
        
        // TinyConsole with custom gesture reconizers
        window?.rootViewController = TinyConsole.createViewController(rootViewController: tabBarController, withDefaultGestureConfiguration: false)
        // single tap
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(consoleTapped))
        tapGestureRecognizer.numberOfTouchesRequired = 1
        TinyConsole.addGestureRecognizer(tapGestureRecognizer)
        // double tap
        let doubleTapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(consoleDoubleTapped))
        doubleTapGestureRecognizer.numberOfTouchesRequired = 2
        TinyConsole.addGestureRecognizer(doubleTapGestureRecognizer)
        tapGestureRecognizer.require(toFail: doubleTapGestureRecognizer)
        // swipe
        let swipeGestureRecognizer = UISwipeGestureRecognizer(target: self, action: #selector(consoleSwiped))
        TinyConsole.addGestureRecognizer(swipeGestureRecognizer)
        
        // Calling this func to set back to default configuration
        // TinyConsole.useDefaultGestureConfiguration()
        
        window?.makeKeyAndVisible()
        
        return true
    }
    
    @objc func consoleTapped(sender: UITapGestureRecognizer) {
        TinyConsole.print("console tapped, do nothing", global: true)
    }
    
    @objc func consoleDoubleTapped(sender: UITapGestureRecognizer) {
        TinyConsole.print("console double tapped, do nothing", global: true)
    }
    
    @objc func consoleSwiped(sender: UISwipeGestureRecognizer) {
        TinyConsole.print("console swipped, change to red view controller", global: true)
        let vc = UIViewController()
        vc.view.backgroundColor = UIColor.red
        TinyConsole.set(rootViewController: vc)
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

