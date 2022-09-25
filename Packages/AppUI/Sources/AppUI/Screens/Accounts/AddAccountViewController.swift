import UIKit
import Domain

public class AddAccountViewController: CardViewController {
    public override var topMargin: CGFloat { 20 }
    private let viewModel: AddAccountViewModelProtocol
    private let accountType: AccountType

    public init(viewModel: AddAccountViewModelProtocol, accountType: AccountType) {
        self.viewModel = viewModel
        self.accountType = accountType
        super.init()
    }

    public override func viewDidLoad() {
        super.viewDidLoad()
        title = "Add Account - \(accountType.rawValue)"
        loadCards()
        bindViewModel()
    }

    public override func navigationRightAction() -> AppBarButtonItem? {
        .init(icon: UIImage(systemName: "xmark.circle")) { [weak self] in
            self?.navigationController?.dismiss(animated: true, completion: nil)
        }
    }

    private func loadCards() {
        cards = [
            AddAccountInputViewCard(saveAction: { [weak self] name, amount in
                self?.saveTapped(with: name, amount: amount)
            })
        ]
    }

    private func bindViewModel() {
        viewModel.saveAccountSuccess.bind { [weak self] status in
            guard status else { return }
            self?.navigationController?.dismiss(animated: true, completion: nil)
        }
    }

    private func saveTapped(with name: String, amount: Double) {
        guard name.count > 0 else { return }
        viewModel.saveAccount(with: .init(
            name: name,
            type: accountType.rawValue,
            initialAmount: amount,
            last4Digit: ""
        ))
    }
}
