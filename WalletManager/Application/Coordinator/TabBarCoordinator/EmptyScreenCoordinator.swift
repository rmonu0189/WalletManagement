import AppUI
import UIKit

class EmptyScreenCoordinator: BaseCoordinator {
    override func start() {
        let controller = AppTabBarEmptyViewController()
        let item = UITabBarItem(
            title: "",
            image: UIImage(
                systemName: "plus",
                withConfiguration: UIImage.SymbolConfiguration(pointSize: 20)
            ),
            selectedImage: nil
        )
        controller.tabBarItem = item
        controller.onDestroy = onDestroy
        navigationController.changeRoot(with: controller)
    }
}
