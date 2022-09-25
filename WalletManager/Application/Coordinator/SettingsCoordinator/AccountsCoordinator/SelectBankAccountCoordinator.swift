import AppUI
import UIKit
import Presentation
import Domain

class SelectBankAccountCoordinator: BaseCoordinator {
    override func start() {
        let controller = SelectBankAccountViewController(
            viewModel: SelectBankAccountViewModel(
                useCaseExecutor: appDiContainer.useCaseExecutor,
                getAllSavingAccountUseCase: appDiContainer.useCaseFactory.getAllSavingAccountUseCase
            )
        )
        controller.onDestroy = onDestroy
        navigationController.pushViewController(controller, animated: true)

        controller.didSelectBankAccountAction = { [weak self] bankAccount in
            self?.startAddDebitCard(with: bankAccount)
        }
    }

    private func startAddDebitCard(with bankAccount: AccountDomainModel) {
        let coordinator = AddBankCardCoordinator(bankAccount: bankAccount, navigation: navigationController)
        addChild(coordinator)
    }
}
