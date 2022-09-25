import AppUI
import UIKit

class AccountsTypeCoordinator: BaseCoordinator {
    override func start() {
        let controller = AccountsTypeViewController()
        controller.onDestroy = onDestroy
        navigationController.viewControllers = [controller]

        controller.didSelectedMenu = { [weak self] menu in
            switch menu {
            case .SavingAccount:
                self?.startAddBankAccount()
            case .CreditCard:
                self?.startAddBankCard()
            case .DebitCard:
                self?.startSelectBankCard()
            default:
                self?.startAddAccount(with: menu)
            }
        }
    }

    private func startAddAccount(with type: AccountType) {
        let coordinator = AddAccountCoordinator(accountType: type, navigation: navigationController)
        addChild(coordinator)
    }

    private func startAddBankAccount() {
        let coordinator = AddBankAccountCoordinator(navigation: navigationController)
        addChild(coordinator)
    }

    private func startAddBankCard() {
        let coordinator = AddBankCardCoordinator(navigation: navigationController)
        addChild(coordinator)
    }

    private func startSelectBankCard() {
        let coordinator = SelectBankAccountCoordinator(navigation: navigationController)
        addChild(coordinator)
    }
}
