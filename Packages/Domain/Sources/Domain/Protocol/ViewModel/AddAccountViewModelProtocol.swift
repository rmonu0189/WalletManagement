import CommonUtility

public protocol AddAccountViewModelProtocol {
    var bankAccount: AccountDomainModel? { get }
    var saveAccountSuccess: Bindable<Bool> { get }
    
    func saveAccount(with model: SaveAccountDomainModel)
    func saveBankAccount(with model: BankAccountDomainModel)
    func saveBankCard(with model: BankCardDomainModel)
}
