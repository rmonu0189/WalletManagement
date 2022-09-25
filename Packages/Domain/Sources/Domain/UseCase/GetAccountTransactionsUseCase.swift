import Foundation

public class GetAccountTransactionsUseCase: BaseUseCase {
    let repository: TransactionRepositoryProtocol

    init(repository: TransactionRepositoryProtocol) {
        self.repository = repository
    }

    public override func execute(input value: Any?) {
        guard let uuid = value as? String else {
            result?(.failed(RequestDomainException.inputException))
            return
        }
        repository.getAllExpenses(for: uuid) { [weak self] expenses in
            self?.result?(.success(expenses))
        }
    }
}
