import UIKit
import Domain

public class AddTransactionViewController: CardViewController {
    public override var topMargin: CGFloat { 20 }
    private let viewModel: AddTransactionViewModelProtocol
    private let type: TransactionType

    public init(viewModel: AddTransactionViewModelProtocol, type: TransactionType) {
        self.viewModel = viewModel
        self.type = type
        super.init()
    }

    public override func viewDidLoad() {
        super.viewDidLoad()
        title = "Add \(type.rawValue)"
        loadCards()
        bindViewModel()
    }

    public override func navigationRightAction() -> AppBarButtonItem? {
        .init(icon: UIImage(systemName: "xmark.circle")) { [weak self] in
            self?.navigationController?.dismiss(animated: true, completion: nil)
        }
    }

    private func loadCards() {
        var toAccounts = [AccountDomainModel]()
        var fromAccounts = [AccountDomainModel]()
        if type == .Expenses {
            toAccounts = viewModel.accounts.value.filter({$0.type == AccountType.Expenses.rawValue})
            fromAccounts = viewModel.accounts.value.filter({
                $0.type == AccountType.Cash.rawValue || $0.type == AccountType.SavingAccount.rawValue || $0.type == AccountType.CreditCard.rawValue || $0.type == AccountType.DebitCard.rawValue
            })
        } else if type == .Income {
            toAccounts = viewModel.accounts.value.filter({
                $0.type == AccountType.Cash.rawValue || $0.type == AccountType.SavingAccount.rawValue || $0.type == AccountType.CreditCard.rawValue
            })
            fromAccounts = viewModel.accounts.value.filter({$0.type == AccountType.Salary.rawValue})
        } else {
            toAccounts = viewModel.accounts.value.filter({$0.type != AccountType.Salary.rawValue && $0.type != AccountType.Expenses.rawValue && $0.type != AccountType.DebitCard.rawValue})
            fromAccounts = viewModel.accounts.value.filter({$0.type == AccountType.General.rawValue || $0.type == AccountType.Cash.rawValue || $0.type == AccountType.DebitCard.rawValue || $0.type == AccountType.CreditCard.rawValue || $0.type == AccountType.SavingAccount.rawValue})
        }
        cards = [
            AddTransactionViewCard(
                toAccounts: toAccounts,
                fromAccounts: fromAccounts,
                saveAction: { [weak self] transaction in
                    self?.viewModel.saveTransaction(transaction)
                }
            )
        ]
    }

    private func bindViewModel() {
        viewModel.accounts.bind { [weak self] _ in
            self?.loadCards()
        }

        viewModel.saveTransactionSuccess.bind { [weak self] status in
            guard status else { return }
            self?.navigationController?.dismiss(animated: true, completion: nil)
        }
    }
}
