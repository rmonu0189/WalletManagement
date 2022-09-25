import UIKit
import Domain

public class HomeViewController: CardViewController {
    public override var topMargin: CGFloat { 12 }
    public override var defaultBackground: UIColor { .lightBackground }
    
    private let viewModel: HomeViewModelProtocol
    private let dateFormat = DateFormatter()

    public init(viewModel: HomeViewModelProtocol) {
        self.viewModel = viewModel
        super.init()
        bindViewModel()
    }

    public override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewModel.loadStatistics()
        viewModel.getMyFinanceAccounts()
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
        viewModel.expenditures.bind { [weak self] _ in
            self?.loadCards()
        }
        viewModel.accounts.bind { [weak self] _ in
            self?.loadCards()
        }
        viewModel.salaryTransactions.bind { [weak self] _ in
            self?.loadCards()
        }
    }

    private func loadCards() {
        dateFormat.dateFormat = "MMMM yyyy"
        navigationItem.title = dateFormat.string(from: viewModel.monthFilter)

        guard let expenditures = viewModel.expenditures.value else { return }
        let models = viewModel.accounts.value.compactMap({PersonAccountView.UiModel(
            title: $0.name,
            subtitle: $0.displaySubtitle,
            amount: $0.balance
        )})
        
        var allCards = [Card]()
        allCards.append(ProgressBarStatisticsViewCard(
            model: ExpenditureDomainModelToPresentationMapper().map(input: expenditures)
        ))

        allCards.append(PersonAccountViewCard(models: models))

        if viewModel.salaryTransactions.value.count > 0 {
            allCards.append(ProgressBarStatisticsViewCard(
                model: SalaryTransactionsToProgressBarStatisticsMapper().map(
                    input: viewModel.salaryTransactions.value
                )
            ))
        }
        cards = allCards
    }
}
