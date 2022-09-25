import Foundation

public class GetMyFinanceAccountsUseCase: BaseUseCase {
    let repository: AccountRepositoryProtocol

    init(repository: AccountRepositoryProtocol) {
        self.repository = repository
    }

    public override func execute(input value: Any?) {
        repository .getMyFinanceAccounts { [weak self] accounts in
            self?.result?(.success(accounts))
        }
    }
}
