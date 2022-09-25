import UIKit
import Domain

public class AddBankAccountViewController: CardViewController {
    public override var topMargin: CGFloat { 20 }
    private let viewModel: AddAccountViewModelProtocol

    public init(viewModel: AddAccountViewModelProtocol) {
        self.viewModel = viewModel
        super.init()
    }

    public override func viewDidLoad() {
        super.viewDidLoad()
        title = "Add Bank Account"
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
            AddBankAccountViewCard(saveAction: { [weak self] bankAccount in
                self?.saveTapped(with: bankAccount)
            })
        ]
    }

    private func bindViewModel() {
        viewModel.saveAccountSuccess.bind { [weak self] status in
            guard status else { return }
            self?.navigationController?.dismiss(animated: true, completion: nil)
        }
    }

    private func saveTapped(with bankAccount: BankAccountDomainModel) {
        guard bankAccount.bankName.count > 0 else { return }
        viewModel.saveBankAccount(with: bankAccount)
    }
}
