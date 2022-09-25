import Foundation

public class GetAllSavingAccountUseCase: BaseUseCase {
    let repository: AccountRepositoryProtocol

    init(repository: AccountRepositoryProtocol) {
        self.repository = repository
    }

    public override func execute(input value: Any?) {
        repository.getAllAccounts { [weak self] accounts in
            self?.result?(.success(accounts.filter({$0.type == "Saving Account"})))
        }
    }
}
