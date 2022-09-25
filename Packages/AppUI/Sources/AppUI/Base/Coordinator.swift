import CommonUtility
import UIKit

public protocol Coordinator: AnyObject {
    var navigationController: CoordinatedNavigationController { get }
    var childCoordinators: [Coordinator] { get }
    var parentCoordinator: BaseCoordinator? { get set }

    func start()
}

open class BaseCoordinator: Coordinator {
    public var navigationController: CoordinatedNavigationController
    public var childCoordinators: [Coordinator] = []
    public var parentCoordinator: BaseCoordinator?

    public var onDestroy: (() -> Void)?

    public init(navigation: CoordinatedNavigationController) {
        navigationController = navigation
        onDestroy = { [weak self] in
            guard let self = self else { return }
            self.parentCoordinator?.removeChild(self)
        }
    }

    public func addChild(_ child: Coordinator) {
        childCoordinators.append(child)
        child.parentCoordinator = self
        child.start()
    }

    public func removeChild(_ child: Coordinator) {
        childCoordinators = childCoordinators.filter { $0 !== child }
    }

    open func start() {
        fatalError("Needs to be implemented in the subclass")
    }

    deinit {
        AppLogger.log("👉 Deinit \(type(of: self))")
    }
}
