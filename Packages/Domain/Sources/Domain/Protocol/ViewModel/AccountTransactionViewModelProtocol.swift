import CommonUtility
import Foundation

public protocol AccountTransactionViewModelProtocol {
    var accountDomainModel: AccountDomainModel { get }
    var allTransactions: Bindable<[TransactionItemDomainModel]> { get }
    func getTransactions()
    func deleteTransaction(at index: Int)
}
