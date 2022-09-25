import CommonUtility
import Domain

public class SelectBankAccountViewModel: SelectBankAccountViewModelProtocol {
    private let useCaseExecutor: UseCaseExecutor
    private let getAllSavingAccountUseCase: GetAllSavingAccountUseCase
    public var allSavingAccounts: Bindable<[AccountDomainModel]> = Bindable([])
    
    public init(useCaseExecutor: UseCaseExecutor, getAllSavingAccountUseCase: GetAllSavingAccountUseCase) {
        self.useCaseExecutor = useCaseExecutor
        self.getAllSavingAccountUseCase = getAllSavingAccountUseCase
    }

    public func fetchAllSavingAccounts() {
        useCaseExecutor.execute(
            useCase: getAllSavingAccountUseCase
        ) { [weak self] result in
            guard let allAccounts = result as? [AccountDomainModel] else { return }
            self?.allSavingAccounts.update(with: allAccounts)
        } failed: { error in
            AppLogger.log(error)
        }
    }
}
