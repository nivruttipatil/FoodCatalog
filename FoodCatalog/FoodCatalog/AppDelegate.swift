//
//  AppDelegate.swift
//  FoodCatalog
//
//  Created by Nivrutti on 23/07/24.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        window = UIWindow(frame:  UIScreen.main.bounds)
        window?.backgroundColor = .white
        window?.rootViewController = FoodBuilder.build()
        window?.makeKeyAndVisible()
        return true
    }
}
