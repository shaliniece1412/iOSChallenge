//
//  AppDelegate.swift
//  SampleTableView
//
//  Created by 922235 on 26/03/20.
//  Copyright © 2020 922235. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
       
        let viewController = ViewController()
        window = UIWindow(frame: UIScreen.main.bounds)
        window!.backgroundColor = UIColor.white
        let navigationController = UINavigationController(rootViewController: viewController)
        window!.rootViewController = navigationController
        window!.makeKeyAndVisible()
        return true
    }
}

