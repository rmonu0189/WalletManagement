import Foundation
import AppUI
import UIKit

class AppTabbarCoordinator: BaseCoordinator {
    override func start() {
        let tabbar = AppTabBarViewController()
        var items = [UIViewController]()
        items.append(addHomeTab())
        items.append(addTransactionsTab())
        items.append(addPlusTab())
        items.append(addAccountsTab())
        items.append(addSettingsTab())
        tabbar.viewControllers = items
        tabbar.onDestroy = onDestroy
        navigationController.changeRoot(with: tabbar)

        tabbar.onAddTransactionAction = { [weak self] type in
            self?.startAddTransaction(for: type)
        }
    }

    private func startAddTransaction(for type: TransactionType) {
        let coordinator = AddTransactionCoordinator(type: type, navigation: navigationController)
        addChild(coordinator)
    }
}

extension AppTabbarCoordinator {
    private func addHomeTab() -> CoordinatedNavigationController {
        let navigation = CoordinatedNavigationController()
        let coordinator = HomeCoordinator(navigation: navigation)
        addChild(coordinator)
        return navigation
    }

    private func addAccountsTab() -> CoordinatedNavigationController {
        let navigation = CoordinatedNavigationController()
        let coordinator = AccountsTabBarCoordinator(navigation: navigation)
        addChild(coordinator)
        return navigation
    }

    private func addTransactionsTab() -> CoordinatedNavigationController {
        let navigation = CoordinatedNavigationController()
        let coordinator = TransactionsCoordinator(navigation: navigation)
        addChild(coordinator)
        return navigation
    }

    private func addPlusTab() -> CoordinatedNavigationController {
        let navigation = CoordinatedNavigationController()
        let coordinator = EmptyScreenCoordinator(navigation: navigation)
        addChild(coordinator)
        return navigation
    }

    private func addSettingsTab() -> CoordinatedNavigationController {
        let navigation = CoordinatedNavigationController()
        let coordinator = SettingsCoordinator(navigation: navigation)
        addChild(coordinator)
        return navigation
    }
}
