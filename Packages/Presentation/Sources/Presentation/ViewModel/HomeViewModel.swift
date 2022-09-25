import Domain
import Foundation
import CommonUtility

public class HomeViewModel: HomeViewModelProtocol {
    public var expenditures: Bindable<Expenditures?> = Bindable(nil)
    public var accounts: Bindable<[AccountDomainModel]> = Bindable([])
    public var salaryTransactions: Bindable<[TransactionItemDomainModel]> = Bindable([])
    public var loadRecords: Bindable<Bool> = Bindable(false)
    public var monthFilter: Date

    private let useCaseExecutor: UseCaseExecutor
    private let getAllExpendituresUseCase: GetAllExpendituresUseCase
    private let getMyFinanceAccountsUseCase: GetMyFinanceAccountsUseCase
    private let getAllSalaryUseCase: GetAllSalaryUseCase
    
    public init(
        useCaseExecutor: UseCaseExecutor,
        getAllExpendituresUseCase: GetAllExpendituresUseCase,
        getMyFinanceAccountsUseCase: GetMyFinanceAccountsUseCase,
        getAllSalaryUseCase: GetAllSalaryUseCase
    ) {
        self.useCaseExecutor = useCaseExecutor
        self.getAllExpendituresUseCase = getAllExpendituresUseCase
        self.getMyFinanceAccountsUseCase = getMyFinanceAccountsUseCase
        self.getAllSalaryUseCase = getAllSalaryUseCase
        self.monthFilter = Date()
    }

    public func getNextMonthTransactions() {
        monthFilter = monthFilter.nextMonth
        loadStatistics()
    }

    public func getPreviousMonthTransactions() {
        monthFilter = monthFilter.previousMonth
        loadStatistics()
    }
    
    public func loadStatistics() {
        getExpenditure()
        getAllSalaryAccounts()
    }

    public func getExpenditure() {
        useCaseExecutor.execute(
            useCase: getAllExpendituresUseCase,
            input: monthFilter
        ) { [weak self] result in
            guard let self = self else { return }
            guard let transactions = result as? [TransactionItemDomainModel] else { return }
            self.expenditures.update(with: self.getExpenditureStatistics(for: transactions))
        } failed: { error in
            AppLogger.log(error)
        }
    }

    public func getAllSalaryAccounts() {
        useCaseExecutor.execute(
            useCase: getAllSalaryUseCase,
            input: monthFilter
        ) { [weak self] result in
            guard let accounts = result as? [TransactionItemDomainModel] else { return }
            self?.salaryTransactions.update(with: accounts)
        } failed: { error in
            AppLogger.log(error)
        }
    }

    public func getMyFinanceAccounts() {
        useCaseExecutor.execute(
            useCase: getMyFinanceAccountsUseCase
        ) { [weak self] result in
            guard let accounts = result as? [AccountDomainModel] else { return }
            self?.accounts.update(with: accounts)
        } failed: { error in
            AppLogger.log(error)
        }
    }

    private func getExpenditureStatistics(for transactions: [TransactionItemDomainModel]) -> Expenditures {
        let expenses = transactions.filter({$0.type == "Expenses"}).compactMap({$0.amount})
        let loans = transactions.filter({$0.type == "Loan"}).compactMap({$0.amount})
        let investments = transactions.filter({$0.type == "Investment"}).compactMap({$0.amount})
        let insurances = transactions.filter({$0.type == "Insurance"}).compactMap({$0.amount})
        let totalExpenses = expenses.reduce(0, +)
        let totalLoan = loans.reduce(0, +)
        let totalInvestment = investments.reduce(0, +)
        let totalInsurance = insurances.reduce(0, +)
        var maxValue = totalExpenses
        if maxValue < totalLoan {
            maxValue = totalLoan
        }
        if maxValue < totalInvestment {
            maxValue = totalInvestment
        }
        if maxValue < totalInsurance {
            maxValue = totalInsurance
        }
        return .init(
            title: "Expenditure",
            totalAmount: totalExpenses + totalLoan + totalInvestment + totalInsurance,
            maxAmount: maxValue,
            expensesAmount: totalExpenses,
            loanAmount: totalLoan,
            investmentAmount: totalInvestment,
            insuranceAmount: totalInsurance
        )
    }
}
