import Domain

class ExpenditureDomainModelToPresentationMapper {
    func map(input: Expenditures) -> ProgressBarStatisticsView.UiModel {
        let statistics: [StatisticsBarView.UiModel] = [
            .init(
                name: AccountType.Expenses.rawValue,
                amount: input.expensesAmount,
                percentage: input.expensesAmount / input.maxAmount, color: .negetiveBalance
            ),
            .init(
                name: AccountType.Loan.rawValue,
                amount: input.loanAmount,
                percentage: input.loanAmount / input.maxAmount, color: .equalBalance
            ),
            .init(
                name: AccountType.Investment.rawValue,
                amount: input.investmentAmount,
                percentage: input.investmentAmount / input.maxAmount, color: .positiveBalance
            ),
            .init(
                name: AccountType.Insurance.rawValue,
                amount: input.insuranceAmount,
                percentage: input.insuranceAmount / input.maxAmount, color: .insuranceAmount
            )
        ]
        return .init(
            title: input.title,
            totalAmount: input.totalAmount,
            statistics: statistics
        )
    }
}
