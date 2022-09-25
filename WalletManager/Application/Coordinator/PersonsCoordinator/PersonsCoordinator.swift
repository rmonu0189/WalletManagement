import AppUI
import UIKit
import Presentation
import Domain

class PersonsCoordinator: BaseCoordinator {
    private let accountTypes: [AccountType]

    init(navigation: CoordinatedNavigationController, accountTypes: [AccountType]) {
        self.accountTypes = accountTypes
        super.init(navigation: navigation)
    }

    override func start() {
        let controller = AccountsViewController(
            viewModel: AccountsViewModel(
                title: "Persons",
                accountTypesFilter: accountTypes.compactMap { $0.rawValue },
                useCaseExecutor: appDiContainer.useCaseExecutor,
                getAllAccountsUseCase: appDiContainer.useCaseFactory.getAllAccountsUseCase
            )
        )
        let item = UITabBarItem(
            title: "Persons",
            image: UIImage(
                systemName: "person",
                withConfiguration: UIImage.SymbolConfiguration(pointSize: 14)
            ),
            selectedImage: nil
        )
        controller.tabBarItem = item
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
        let coordinator = AddAccountCoordinator(accountType: .General, navigation: presentedNavigation)
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
