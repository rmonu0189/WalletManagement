import AppUI
import UIKit
import Presentation

class AddAccountCoordinator: BaseCoordinator {
    private let accountType: AccountType

    init(accountType: AccountType, navigation: CoordinatedNavigationController) {
        self.accountType = accountType
        super.init(navigation: navigation)
    }

    override func start() {
        let controller = AddAccountViewController(
            viewModel: AddAccountViewModel(
                useCaseExecutor: appDiContainer.useCaseExecutor,
                saveAccountUseCase: appDiContainer.useCaseFactory.saveAccountUseCase
            ),
            accountType: accountType
        )
        controller.onDestroy = onDestroy
        navigationController.pushViewController(controller, animated: true)
    }
}
