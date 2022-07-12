//
//  AppDelegate.swift
//  kingbobne-ios
//
//  Created by 강대규 on 2022/06/25.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        self.window = UIWindow(frame: UIScreen.main.bounds)
        self.window?.rootViewController = SplashViewController()
        self.window?.makeKeyAndVisible()
        return true
    }
}

