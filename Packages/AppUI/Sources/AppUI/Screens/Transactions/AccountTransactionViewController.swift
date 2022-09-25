import UIKit
import Domain

public class AccountTransactionViewController: BaseListViewController {
    private let viewModel: AccountTransactionViewModelProtocol
    private let dateFormatter = DateFormatter()

    public init(viewModel: AccountTransactionViewModelProtocol) {
        self.viewModel = viewModel
        super.init()
    }

    public override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = viewModel.accountDomainModel.displayName
        bindViewModel()
    }

    public override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewModel.getTransactions()
    }

    public override func registerCell(for tableView: DPTableView) {
        tableView.register(cell: ViewWrapperTableCell<TransactionItemView>.self)
    }

    public override func tableView(
        _ tableView: UITableView,
        trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath
    ) -> UISwipeActionsConfiguration? {
        let delete = UIContextualAction(
            style: .destructive,
            title: "DELETE"
        ) { [weak self] _, _, completionHandler in
            self?.showConfirmAlert(with: "Are you sure? You want to delete this transaction.", action: {
                self?.viewModel.deleteTransaction(at: indexPath.item)
            })
            completionHandler(true)
        }
        return UISwipeActionsConfiguration(actions: [delete])
    }

    private func bindViewModel() {
        viewModel.allTransactions.bind { [weak self] transactions in
            self?.loadSections(for: transactions)
        }
    }

    private func loadSections(for transactions: [TransactionItemDomainModel]) {
        dateFormatter.dateFormat = "dd MMMM yyyy"
        let items = transactions.compactMap({
            TransactionItemView.UiModel(
                title: $0.toAccountName,
                subtitle: $0.fromAccountName,
                amount: viewModel.accountDomainModel.uuid == $0.fromAccountUuid ? -$0.amount : $0.amount,
                type: $0.type,
                date: dateFormatter.string(from: $0.date ?? Date())
            )
        })
        sections = [
            DPSection(
                cell: ViewWrapperTableCell<TransactionItemView>.self,
                items: items
            )
        ]
    }
}
