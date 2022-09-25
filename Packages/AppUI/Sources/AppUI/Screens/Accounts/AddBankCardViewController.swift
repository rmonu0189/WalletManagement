import UIKit
import Domain

public class AddBankCardViewController: CardViewController {
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
            AddBankCardViewCard(
                bankAccount: viewModel.bankAccount,
                saveAction: { [weak self] card in
                    self?.saveTapped(with: card)
                }
            )
        ]
    }

    private func bindViewModel() {
        viewModel.saveAccountSuccess.bind { [weak self] status in
            guard status else { return }
            self?.navigationController?.dismiss(animated: true, completion: nil)
        }
    }

    private func saveTapped(with card: BankCardDomainModel) {
        guard card.bankName.count > 0 else { return }
        guard card.cardNumber.count > 0 else { return }
        guard card.expiryDate.count > 0 else { return }
        guard card.cvv.count > 0 else { return }
        guard card.nameOnCard.count > 0 else { return }
        viewModel.saveBankCard(with: card)
    }
}
