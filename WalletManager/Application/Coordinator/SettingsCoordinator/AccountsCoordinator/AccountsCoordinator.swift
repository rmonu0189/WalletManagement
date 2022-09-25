import AppUI
import UIKit
import Domain
import Presentation

class AccountsCoordinator: BaseCoordinator {
    override func start() {
        let controller = AccountsViewController(
            viewModel: AccountsViewModel(
                title: "Accounts",
                accountTypesFilter: [],
                useCaseExecutor: appDiContainer.useCaseExecutor,
                getAllAccountsUseCase: appDiContainer.useCaseFactory.getAllAccountsUseCase
            )
        )
        controller.hidesBottomBarWhenPushed = true
        controller.onDestroy = onDestroy
        navigationController.pushViewController(controller, animated: true)

        controller.onAddAccountAction = { [weak self] in
            self?.startSelectAccountType()
        }
        controller.onSelectAccountAction = { [weak self] accountDomainModel in
            self?.startAccountDetails(for: accountDomainModel)
        }
    }

    private func startSelectAccountType() {
        let presentedNavigation = CoordinatedNavigationController()
        presentedNavigation.modalPresentationStyle = .fullScreen
        let coordinator = AccountsTypeCoordinator(navigation: presentedNavigation)
        addChild(coordinator)
        navigationController.present(presentedNavigation, animated: true)
    }

    private func startAccountDetails(for accountDomainModel: AccountDomainModel) {
        let coordinator = AccountTransactionsCoordinator(
            accountDomainModel: accountDomainModel,
            navigation: navigationController
        )
        addChild(coordinator)
    }
}
