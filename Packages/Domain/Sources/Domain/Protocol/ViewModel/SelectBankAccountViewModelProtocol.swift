import CommonUtility

public protocol SelectBankAccountViewModelProtocol {
    var allSavingAccounts: Bindable<[AccountDomainModel]> { get }
    func fetchAllSavingAccounts()
}
