import UIKit

public class SettingssViewController: BaseListViewController {
    public enum Menu: Int, CaseIterable {
        case person
        case bankAccount
        case card
        case backup

        func menuViewUiModel() -> MenuView.UiModel {
            switch self {
            case .person:
                return .init(icon: "person", title: "Persons")
            case .bankAccount:
                return .init(icon: "building.columns", title: "Bank Accounts")
            case .card:
                return .init(icon: "creditcard", title: "Cards")
            case .backup:
                return .init(icon: "cloud", title: "Backup")
            }
        }
    }

    public var didSelectedMenu: ((Menu) -> Void)?

    public override func registerCell(for tableView: DPTableView) {
        tableView.register(cell: ViewWrapperTableCell<MenuView>.self)
    }

    public override func viewDidLoad() {
        super.viewDidLoad()
        title = "Settings"

        sections = [
            DPSection(
                cell: ViewWrapperTableCell<MenuView>.self,
                items: Menu.allCases.compactMap({$0.menuViewUiModel()}),
                accessoryType: .disclosureIndicator
            )
        ]
    }

    public override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let menu = Menu(rawValue: indexPath.item) else { return }
        didSelectedMenu?(menu)
    }
}
