import CommonUtility

public protocol AccountsViewModelProtocol {
    var title: String { get }
    var allAccounts: Bindable<[AccountDomainModel]> { get }
    var accountTypesFilter: [String] { get }
    func fetchAllAccounts()
}
