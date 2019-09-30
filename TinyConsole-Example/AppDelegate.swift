//
//  AppDelegate.swift
//  TinyConsole-Example
//
//  Created by Devran Uenal on 28.11.16.
//
//

import TinyConsole
import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        window = UIWindow(frame: UIScreen.main.bounds)
        
        let tabBarController = UITabBarController()
        tabBarController.viewControllers = [
            UINavigationController(rootViewController: MainViewController())
        ]
        
        window?.rootViewController = TinyConsole.createViewController(rootViewController: tabBarController)
        window?.makeKeyAndVisible()
        
        return true
    }
}
