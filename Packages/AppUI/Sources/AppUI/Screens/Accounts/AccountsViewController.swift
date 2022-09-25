import UIKit
import Domain

public class AccountsViewController: BaseListViewController {
    private let viewModel: AccountsViewModelProtocol

    public var onAddAccountAction: (() -> Void)?
    public var onSelectAccountAction: ((AccountDomainModel) -> Void)?

    public init(viewModel: AccountsViewModelProtocol) {
        self.viewModel = viewModel
        super.init()
    }

    public override func registerCell(for tableView: DPTableView) {
        tableView.register(cell: ViewWrapperTableCell<PersonAccountView>.self)
    }

    public override func viewDidLoad() {
        super.viewDidLoad()
        title = viewModel.title
        bindViewModel()
    }

    public override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewModel.fetchAllAccounts()
    }

    public override func navigationRightAction() -> AppBarButtonItem? {
        .init(
            icon: UIImage(systemName: "plus.circle"),
            actionHandler: { [weak self] in
                self?.onAddAccountAction?()
            }
        )
    }

    private func bindViewModel() {
        viewModel.allAccounts.bind { [weak self] accounts in
            self?.loadSections(for: accounts)
        }
    }

    private func loadSections(for accounts: [AccountDomainModel]) {
        var filtered = [AccountDomainModel]()
        if viewModel.accountTypesFilter.count > 0 {
            for item in accounts {
                if viewModel.accountTypesFilter.contains(item.type) {
                    filtered.append(item)
                }
            }
        } else {
            filtered = accounts
        }
        let allItems = filtered.compactMap({PersonAccountView.UiModel(
            title: $0.name,
            subtitle: $0.displaySubtitle,
            amount: $0.balance
        )})

        sections = [
            DPSection(
                cell: ViewWrapperTableCell<PersonAccountView>.self,
                items: allItems,
                accessoryType: .disclosureIndicator
            )
        ]
    }
    
    public override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let item = viewModel.allAccounts.value[indexPath.item]
        onSelectAccountAction?(item)
    }
}
