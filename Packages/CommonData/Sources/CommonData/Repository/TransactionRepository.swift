import Domain
import Foundation

struct TransactionRepository: TransactionRepositoryProtocol {
    let datasource: TransactionLocalDataSources

    init(datasource: TransactionLocalDataSources) {
        self.datasource = datasource
    }

    func saveTransaction(with model: TransactionDomainModel) {
        datasource.saveTransaction(model)
    }

    func deleteTransaction(with uuid: String) {
        datasource.deleteTransaction(with: uuid)
    }

    func getAllTransactions(for month: Date?, handler: ([TransactionItemDomainModel]) -> Void) {
        handler(datasource.getAllTransactions(for: month))
    }

    func getAllExpenses(for month: Date?, handler: ([TransactionItemDomainModel]) -> Void) {
        handler(datasource.getAllExpenses(for: month))
    }

    func getAllExpenses(for accountUuid: String, handler: ([TransactionItemDomainModel]) -> Void) {
        handler(datasource.getAllExpenses(for: accountUuid))
    }

    func getAllExpenditures(for month: Date?, handler: ([TransactionItemDomainModel]) -> Void) {
        handler(datasource.getAllExpenditures(for: month))
    }

    func getAllSalary(for month: Date?, handler: ([TransactionItemDomainModel]) -> Void) {
        handler(datasource.getAllSalary(for: month))
    }
}
