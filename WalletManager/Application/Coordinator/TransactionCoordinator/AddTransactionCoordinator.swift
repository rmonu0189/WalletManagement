import AppUI
import UIKit
import Presentation

class AddTransactionCoordinator: BaseCoordinator {
    let presentedNavigation = CoordinatedNavigationController()
    private let type: TransactionType

    init(type: TransactionType, navigation: CoordinatedNavigationController) {
        self.type = type
        super.init(navigation: navigation)
    }

    override func start() {
        let controller = AddTransactionViewController(
            viewModel: AddTransactionViewModel(
                useCaseExecutor: appDiContainer.useCaseExecutor,
                getAllAccountsUseCase: appDiContainer.useCaseFactory.getAllAccountsUseCase,
                saveTransactionUseCase: appDiContainer.useCaseFactory.saveTransactionUseCase
            ),
            type: type
        )
        controller.onDestroy = onDestroy
        presentedNavigation.viewControllers = [controller]
        presentedNavigation.modalPresentationStyle = .fullScreen
        navigationController.present(presentedNavigation, animated: true, completion: nil)
    }
}
