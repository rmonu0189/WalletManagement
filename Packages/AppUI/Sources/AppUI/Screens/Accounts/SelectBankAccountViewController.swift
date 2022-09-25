import UIKit
import Domain

public class SelectBankAccountViewController: BaseListViewController {
    private let viewModel: SelectBankAccountViewModelProtocol

    public var didSelectBankAccountAction: ((AccountDomainModel) -> Void)?
    public var addBankAccountAction: (() -> Void)?

    public init(viewModel: SelectBankAccountViewModelProtocol) {
        self.viewModel = viewModel
        super.init()
    }

    public override func registerCell(for tableView: DPTableView) {
        tableView.register(cell: ViewWrapperTableCell<PersonAccountView>.self)
    }

    public override func viewDidLoad() {
        super.viewDidLoad()
        title = "Choose Bank Account"
        bindViewModel()
    }

    public override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewModel.fetchAllSavingAccounts()
    }

    private func bindViewModel() {
        viewModel.allSavingAccounts.bind { [weak self] accounts in
            self?.loadSections(for: accounts)
        }
    }

    private func loadSections(for accounts: [AccountDomainModel]) {
        let allItems = accounts.compactMap({PersonAccountView.UiModel(
            title: $0.name,
            subtitle: $0.type,
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
        let item = viewModel.allSavingAccounts.value[indexPath.item]
        didSelectBankAccountAction?(item)
    }
}
