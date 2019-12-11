//
//  AppDelegate.swift
//  musicPlayerTestApp
//
//  Created by Admin on 27.10.2019.
//  Copyright © 2019 Aleksei Kakoulin. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {

        self.window = UIWindow(frame: UIScreen.main.bounds)

        let listViewController: ListViewController = ListViewController()
        let navigationController: UINavigationController =
            UINavigationController(rootViewController: listViewController)

        self.window!.rootViewController = navigationController

        self.window!.backgroundColor = UIColor.white
        self.window!.makeKeyAndVisible()

        return true
    }
}
