import Foundation
import UIKit

public enum TransactionType: String, CaseIterable {
    case Expenses
    case Transfer
    case Income
}

public class AppTabBarViewController: CoordinatedTabbarController, UITabBarControllerDelegate {
    private var actionSheet: ActionSheet!

    public var onAddTransactionAction: ((TransactionType) -> Void)?
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        setupActionSheet()
        delegate = self
    }

    private func setupActionSheet() {
        actionSheet = .init(
            items: TransactionType.allCases.compactMap({$0.rawValue}),
            title: "Chhose Transaction Type",
            actionHandler: { [weak self] action in
                guard let selected = TransactionType(rawValue: action) else { return }
                self?.onAddTransactionAction?(selected)
            })
    }
    
    public func tabBarController(_ tabBarController: UITabBarController, shouldSelect viewController: UIViewController) -> Bool {
        let controller = (viewController as? CoordinatedNavigationController)?.viewControllers.first
        if controller is AppTabBarEmptyViewController {
            actionSheet.show(at: self)
            return false
        }
        return true
    }
}
