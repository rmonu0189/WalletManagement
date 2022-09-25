import AppUI
import UIKit
import Domain
import Presentation

class AccountTransactionsCoordinator: BaseCoordinator {
    private let accountDomainModel: AccountDomainModel

    init(accountDomainModel: AccountDomainModel, navigation: CoordinatedNavigationController) {
        self.accountDomainModel = accountDomainModel
        super.init(navigation: navigation)
    }

    override func start() {
        let controller = AccountTransactionViewController(
            viewModel: AccountTransactionViewModel(
                accountDomainModel: accountDomainModel,
                useCaseExecutor: appDiContainer.useCaseExecutor,
                getAccountTransactionsUseCase: appDiContainer.useCaseFactory.getAccountTransactionsUseCase,
                deleteTransactionUseCase: appDiContainer.useCaseFactory.deleteTransactionUseCase
            )
        )
        controller.onDestroy = onDestroy
        navigationController.pushViewController(controller, animated: true)
    }
}
