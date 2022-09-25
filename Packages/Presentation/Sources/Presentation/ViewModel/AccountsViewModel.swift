import CommonUtility
import Domain
import Foundation

public class AccountsViewModel: AccountsViewModelProtocol {
    private let useCaseExecutor: UseCaseExecutor
    private let getAllAccountsUseCase: GetAllAccountsUseCase
    public var title: String
    public var accountTypesFilter: [String]
    public var allAccounts: Bindable<[AccountDomainModel]> = Bindable([])

    public init(
        title: String,
        accountTypesFilter: [String],
        useCaseExecutor: UseCaseExecutor,
        getAllAccountsUseCase: GetAllAccountsUseCase
    ) {
        self.title = title
        self.accountTypesFilter = accountTypesFilter
        self.useCaseExecutor = useCaseExecutor
        self.getAllAccountsUseCase = getAllAccountsUseCase
    }

    public func fetchAllAccounts() {
        useCaseExecutor.execute(
            useCase: getAllAccountsUseCase
        ) { [weak self] result in
            guard let self = self else { return }
            guard let allAccounts = result as? [AccountDomainModel] else { return }
            if self.accountTypesFilter.count > 0 {
                var filtered = [AccountDomainModel]()
                for item in allAccounts {
                    if self.accountTypesFilter.contains(item.type) {
                        filtered.append(item)
                    }
                }
                self.allAccounts.update(with: filtered)
            } else {
                self.allAccounts.update(with: allAccounts)
            }
        } failed: { error in
            AppLogger.log(error)
        }
    }
}
