//
//  AppDelegate.swift
//  AxxessChallenge
//
//  Created by Balaji Peddaiahgari on 8/15/19.
//  Copyright © 2019 Balaji Peddaiahgari. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.makeKeyAndVisible()
        let typeVC = ViewController()
        let navController = UINavigationController(rootViewController: typeVC)
        window?.rootViewController = navController
        return true
    }
}

