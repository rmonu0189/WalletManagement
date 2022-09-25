import UIKit

public enum AccountType: String, CaseIterable {
    case General
    case Cash
    case SavingAccount = "Saving Account"
    case CreditCard = "Credit Card"
    case DebitCard = "Debit Card"
    case Insurance
    case Investment
    case Loan
    case Expenses
    case Salary

    public var icon: String {
        switch self {
        case .General:
            return "list.dash"
        case .Cash:
            return "rupeesign.square"
        case .SavingAccount:
            return "building.columns"
        case .CreditCard, .DebitCard:
            return "creditcard"
        case .Insurance:
            return "bolt.shield"
        case .Investment:
            return "bag.badge.plus"
        case .Loan:
            return "banknote"
        case .Expenses:
            return "cart"
        case .Salary:
            return "dollarsign.circle"
        }
    }
}

public class AccountsTypeViewController: BaseListViewController {
    public var didSelectedMenu: ((AccountType) -> Void)?

    public override func registerCell(for tableView: DPTableView) {
        tableView.register(cell: ViewWrapperTableCell<MenuView>.self)
    }

    public override func viewDidLoad() {
        super.viewDidLoad()
        title = "Choose Account Type"

        sections = [
            DPSection(
                cell: ViewWrapperTableCell<MenuView>.self,
                items: AccountType.allCases.compactMap({ MenuView.UiModel(icon: $0.icon, title: $0.rawValue) }),
                accessoryType: .disclosureIndicator
            )
        ]
    }

    public override func navigationRightAction() -> AppBarButtonItem? {
        .init(icon: UIImage(systemName: "xmark.circle")) { [weak self] in
            self?.navigationController?.dismiss(animated: true, completion: nil)
        }
    }

    public override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let menu = AccountType(rawValue: AccountType.allCases[indexPath.item].rawValue) else { return }
        didSelectedMenu?(menu)
    }
}
