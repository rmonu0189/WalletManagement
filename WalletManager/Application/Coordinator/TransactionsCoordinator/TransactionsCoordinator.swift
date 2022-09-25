import AppUI
import UIKit
import Presentation

class TransactionsCoordinator: BaseCoordinator {
    override func start() {
        let controller = TransactionViewController(
            viewModel: TransactionViewModel(
                useCaseExecutor: appDiContainer.useCaseExecutor,
                getAllTransactionsUseCase: appDiContainer.useCaseFactory.getAllTransactionsUseCase
            )
        )
        let item = UITabBarItem(
            title: "Transactions",
            image: UIImage(
                systemName: "list.bullet",
                withConfiguration: UIImage.SymbolConfiguration(pointSize: 14)
            ),
            selectedImage: nil
        )
        controller.tabBarItem = item
        controller.onDestroy = onDestroy
        navigationController.changeRoot(with: controller)
    }
}
