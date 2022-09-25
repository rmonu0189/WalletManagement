import CommonUtility
import Foundation

public protocol TransactionViewModelProtocol {
    var allTransactions: Bindable<[TransactionItemDomainModel]> { get }
    var monthFilter: String { get }
    func getTransactions()
    func getNextMonthTransactions()
    func getPreviousMonthTransactions()
}
