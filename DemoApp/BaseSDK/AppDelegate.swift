//
//  AppDelegate.swift
//  AppModule
//
//  Created by zvika on 1/21/20.
//  Copyright © 2022 Passio Inc. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions
        launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {

        window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = VideoViewController()
        window?.makeKeyAndVisible()

        return true
    }

}
