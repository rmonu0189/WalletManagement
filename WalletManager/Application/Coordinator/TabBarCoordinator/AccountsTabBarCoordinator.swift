import AppUI
import Domain
import UIKit
import Presentation

class AccountsTabBarCoordinator: BaseCoordinator {
    override func start() {
        let controller = AccountsViewController(
            viewModel: AccountsViewModel(
                title: "Accounts",
                accountTypesFilter: [],
                useCaseExecutor: appDiContainer.useCaseExecutor,
                getAllAccountsUseCase: appDiContainer.useCaseFactory.getAllAccountsUseCase
            )
        )
        let item = UITabBarItem(
            title: "Accounts",
            image: UIImage(
                systemName: "books.vertical",
                withConfiguration: UIImage.SymbolConfiguration(pointSize: 14)
            ),
            selectedImage: nil
        )
        controller.tabBarItem = item
        controller.onDestroy = onDestroy
        navigationController.changeRoot(with: controller)

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
