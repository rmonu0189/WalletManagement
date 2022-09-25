import Domain
import Foundation
import UIKit

public class TransactionViewController: BaseListViewController {
    private let viewModel: TransactionViewModelProtocol
    private let dateFormatter = DateFormatter()

    public init(viewModel: TransactionViewModelProtocol) {
        self.viewModel = viewModel
        super.init()
    }

    public override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Expenses - \(viewModel.monthFilter)"
        bindViewModel()
    }

    public override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewModel.getTransactions()
    }

    public override func registerCell(for tableView: DPTableView) {
        tableView.register(cell: ViewWrapperTableCell<TransactionItemView>.self)
    }

    public override func navigationLeftAction() -> AppBarButtonItem? {
        .init(icon: UIImage(systemName: "chevron.left")) { [weak self] in
            self?.viewModel.getPreviousMonthTransactions()
        }
    }

    public override func navigationRightAction() -> AppBarButtonItem? {
        .init(icon: UIImage(systemName: "chevron.right")) { [weak self] in
            self?.viewModel.getNextMonthTransactions()
        }
    }

    private func bindViewModel() {
        viewModel.allTransactions.bind { [weak self] transactions in
            self?.loadSections(for: transactions)
        }
    }

    private func loadSections(for transactions: [TransactionItemDomainModel]) {
        dateFormatter.dateFormat = "dd MMMM yyyy"
        navigationItem.title = viewModel.monthFilter
        let items = transactions.compactMap({
            TransactionItemView.UiModel(
                title: $0.toAccountName,
                subtitle: $0.fromAccountName,
                amount: $0.amount,
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
