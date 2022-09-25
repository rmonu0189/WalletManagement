import AppUI
import UIKit
import Presentation
import Domain

class AddBankCardCoordinator: BaseCoordinator {
    private let bankAccount: AccountDomainModel?

    init(bankAccount: AccountDomainModel? = nil, navigation: CoordinatedNavigationController) {
        self.bankAccount = bankAccount
        super.init(navigation: navigation)
    }

    override func start() {
        let controller = AddBankCardViewController(
            viewModel: AddAccountViewModel(
                useCaseExecutor: appDiContainer.useCaseExecutor,
                saveAccountUseCase: appDiContainer.useCaseFactory.saveAccountUseCase,
                bankAccount: bankAccount
            )
        )
        controller.onDestroy = onDestroy
        navigationController.pushViewController(controller, animated: true)
    }
}
