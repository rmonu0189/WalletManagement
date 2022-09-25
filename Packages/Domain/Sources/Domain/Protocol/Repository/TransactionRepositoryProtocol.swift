import Foundation

public protocol TransactionRepositoryProtocol {
    func saveTransaction(with model: TransactionDomainModel)
    func getAllTransactions(for month: Date?, handler: ([TransactionItemDomainModel]) -> Void)
    func getAllExpenses(for month: Date?, handler: ([TransactionItemDomainModel]) -> Void)
    func getAllExpenses(for accountUuid: String, handler: ([TransactionItemDomainModel]) -> Void)
    func getAllExpenditures(for month: Date?, handler: ([TransactionItemDomainModel]) -> Void)
    func getAllSalary(for month: Date?, handler: ([TransactionItemDomainModel]) -> Void)
    func deleteTransaction(with uuid: String)
}
