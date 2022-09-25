import CommonUtility

public protocol AddTransactionViewModelProtocol {
    var accounts: Bindable<[AccountDomainModel]> { get }
    var saveTransactionSuccess: Bindable<Bool> { get }
    func saveTransaction(_ transaction: TransactionDomainModel)
}
