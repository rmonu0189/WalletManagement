import CommonUtility
import Foundation

public protocol HomeViewModelProtocol {
    var expenditures: Bindable<Expenditures?> { get }
    var accounts: Bindable<[AccountDomainModel]> { get }
    var salaryTransactions: Bindable<[TransactionItemDomainModel]> { get }
    var monthFilter: Date { get }
    func getNextMonthTransactions()
    func getPreviousMonthTransactions()
    func loadStatistics()
    func getMyFinanceAccounts()
}
