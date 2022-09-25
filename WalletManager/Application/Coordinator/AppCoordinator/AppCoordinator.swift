//
//  AppCoordinator.swift
//  WalletManager
//
//  Created by Monu Rathor on 22/04/22.
//

import Foundation
import AppUI

class AppCoordinator: BaseCoordinator {
    override func start() {
        startAppTabBar()
    }

    private func startAppTabBar() {
        let coordinator = AppTabbarCoordinator(navigation: navigationController)
        addChild(coordinator)
    }
}
