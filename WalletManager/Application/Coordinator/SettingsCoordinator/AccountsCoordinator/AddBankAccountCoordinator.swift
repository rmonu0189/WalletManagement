import AppUI
import UIKit
import Presentation

class AddBankAccountCoordinator: BaseCoordinator {
    override func start() {
        let controller = AddBankAccountViewController(
            viewModel: AddAccountViewModel(
                useCaseExecutor: appDiContainer.useCaseExecutor,
                saveAccountUseCase: appDiContainer.useCaseFactory.saveAccountUseCase
            )
        )
        controller.onDestroy = onDestroy
        navigationController.pushViewController(controller, animated: true)
    }
}
