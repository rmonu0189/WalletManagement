import CommonUtility
import Domain
import Foundation

public class TransactionViewModel: TransactionViewModelProtocol {
    public var allTransactions: Bindable<[TransactionItemDomainModel]> = Bindable([])
    public var monthFilter: String

    private let useCaseExecutor: UseCaseExecutor
    private let getAllTransactionsUseCase: GetAllTransactionsUseCase
    private let dateFormatter = DateFormatter()
    
    public init(useCaseExecutor: UseCaseExecutor, getAllTransactionsUseCase: GetAllTransactionsUseCase) {
        self.useCaseExecutor = useCaseExecutor
        self.getAllTransactionsUseCase = getAllTransactionsUseCase
        dateFormatter.dateFormat = "MMMM yyyy"
        monthFilter = dateFormatter.string(from: Date())
    }

    public func getNextMonthTransactions() {
        guard let date = dateFormatter.date(from: monthFilter) else { return }
        monthFilter = dateFormatter.string(from: date.nextMonth)
        getTransactions()
    }
    
    public func getPreviousMonthTransactions() {
        guard let date = dateFormatter.date(from: monthFilter) else { return }
        monthFilter = dateFormatter.string(from: date.previousMonth)
        getTransactions()
    }

    public func getTransactions() {
        useCaseExecutor.execute(
            useCase: getAllTransactionsUseCase,
            input: dateFormatter.date(from: monthFilter)
        ) { [weak self] result in
            guard let transactions = result as? [TransactionItemDomainModel] else { return }
            self?.allTransactions.update(with: transactions)
        } failed: { error in
            AppLogger.log(error)
        }
    }
}
