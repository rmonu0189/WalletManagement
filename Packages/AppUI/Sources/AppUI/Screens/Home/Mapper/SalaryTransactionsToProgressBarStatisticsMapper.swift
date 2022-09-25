import Domain
class SalaryTransactionsToProgressBarStatisticsMapper {
    func map(input: [TransactionItemDomainModel]) -> ProgressBarStatisticsView.UiModel {
        let totalAmount = input.compactMap({$0.amount}).reduce(0, +)
        var statistics: [StatisticsBarView.UiModel] = []
        for item in input {
            statistics.append(.init(
                name: item.toAccountName,
                amount: item.amount,
                percentage: item.amount / totalAmount,
                color: item.toAccountName.namedColor() ?? .positiveBalance
            ))
        }
        return .init(
            title: "Salary",
            totalAmount: totalAmount,
            statistics: statistics
        )
    }
}
