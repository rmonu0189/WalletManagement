import AppUI
import UIKit
import Presentation

class HomeCoordinator: BaseCoordinator {
    override func start() {
        let controller = HomeViewController(
            viewModel: HomeViewModel(
                useCaseExecutor: appDiContainer.useCaseExecutor,
                getAllExpendituresUseCase: appDiContainer.useCaseFactory.getAllExpendituresUseCase,
                getMyFinanceAccountsUseCase: appDiContainer.useCaseFactory.getMyFinanceAccountsUseCase,
                getAllSalaryUseCase: appDiContainer.useCaseFactory.getAllSalaryUseCase
            )
        )
        let item = UITabBarItem(
            title: "Home",
            image: UIImage(
                systemName: "house",
                withConfiguration: UIImage.SymbolConfiguration(pointSize: 14)
            ),
            selectedImage: nil
        )
        controller.tabBarItem = item
        controller.onDestroy = onDestroy
        navigationController.changeRoot(with: controller)
    }
}
