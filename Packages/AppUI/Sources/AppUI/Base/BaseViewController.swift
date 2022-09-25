import UIKit
import CommonUtility

open class BaseViewController: UIViewController {
    open var defaultBackground: UIColor { .background }
    public var onDestroy: (() -> Void)?

    public init() {
        super.init(nibName: nil, bundle: nil)
    }

    @available(*, unavailable)
    required public init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    open override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = defaultBackground
        setupNavigationActions()
    }

    open func navigationRightActions() -> [AppBarButtonItem] { [] }
    open func navigationLeftActions() -> [AppBarButtonItem] { [] }
    open func navigationRightAction() -> AppBarButtonItem? { nil }
    open func navigationLeftAction() -> AppBarButtonItem? { nil }

    private func setupNavigationActions() {
        if let action = navigationRightAction() {
            navigationItem.rightBarButtonItems = [action]
        } else {
            navigationItem.rightBarButtonItems = navigationRightActions()
        }
        if let action = navigationLeftAction() {
            navigationItem.leftBarButtonItems = [action]
        } else {
            navigationItem.leftBarButtonItems = navigationLeftActions()
        }
    }

    func showConfirmAlert(with title: String, action: (() -> Void)?) {
        let alert = UIAlertController(title: title, message: nil, preferredStyle: .alert)
        alert.addAction(.init(title: "No", style: .default))
        alert.addAction(.init(title: "Yes", style: .destructive, handler: { _ in
            action?()
        }))
        present(alert, animated: true)
    }

    deinit {
        onDestroy?()
        AppLogger.log("👉 Deinit \(type(of: self))")
    }
}
