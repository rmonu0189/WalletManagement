//
//  AppDelegate.swift
//  WalletManager
//
//  Created by Monu Rathor on 22/04/22.
//

import UIKit
import AppUI

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?

    private lazy var navigation: CoordinatedNavigationController = {
        let navigation = CoordinatedNavigationController()
        navigation.setNavigationBarHidden(true, animated: false)
        return navigation
    }()

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        let coordinator = AppCoordinator(navigation: navigation)
        coordinator.start()

        window = UIWindow()
        window?.rootViewController = navigation
        window?.makeKeyAndVisible()
        return true
    }
}

