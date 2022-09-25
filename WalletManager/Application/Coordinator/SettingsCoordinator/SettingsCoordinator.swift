import AppUI
import UIKit

class SettingsCoordinator: BaseCoordinator {
    override func start() {
        let controller = SettingssViewController()
        let item = UITabBarItem(
            title: "Settings",
            image: UIImage(
                systemName: "gear",
                withConfiguration: UIImage.SymbolConfiguration(pointSize: 14)
            ),
            selectedImage: nil
        )
        controller.tabBarItem = item
        controller.onDestroy = onDestroy
        navigationController.changeRoot(with: controller)

        controller.didSelectedMenu = { [weak self] menu in
            switch menu {
            case .person:
                self?.startPersons()
            default:
                break
            }
        }
    }

    private func startPersons() {
        let coordinator = PersonsCoordinator(navigation: navigationController, accountTypes: [.General])
        addChild(coordinator)
    }
}
