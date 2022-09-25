import CommonUtility
import Domain
import Foundation

public class AddTransactionViewModel: AddTransactionViewModelProtocol {
    public var saveTransactionSuccess: Bindable<Bool> = Bindable(false)
    public var accounts: Bindable<[AccountDomainModel]>
    private let useCaseExecutor: UseCaseExecutor
    private let getAllAccountsUseCase: GetAllAccountsUseCase
    private let saveTransactionUseCase: SaveTransactionUseCase
    
    public init(
        useCaseExecutor: UseCaseExecutor,
        getAllAccountsUseCase: GetAllAccountsUseCase,
        saveTransactionUseCase: SaveTransactionUseCase
    ) {
        self.useCaseExecutor = useCaseExecutor
        self.getAllAccountsUseCase = getAllAccountsUseCase
        self.saveTransactionUseCase = saveTransactionUseCase
        self.accounts = Bindable([])
        fetchAllAccounts()
    }

    public func fetchAllAccounts() {
        useCaseExecutor.execute(
            useCase: getAllAccountsUseCase
        ) { [weak self] result in
            guard let allAccounts = result as? [AccountDomainModel] else { return }
            self?.accounts.update(with: allAccounts)
        } failed: { error in
            print(error)
        }
    }

    public func saveTransaction(_ transaction: TransactionDomainModel) {
        useCaseExecutor.execute(
            useCase: saveTransactionUseCase,
            input: transaction
        ) { [weak self] result in
            self?.saveTransactionSuccess.update(with: true)
        } failed: { error in
            AppLogger.log(error)
        }
    }
}
