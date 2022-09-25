import Foundation

public class DeleteTransactionUseCase: BaseUseCase {
    let repository: TransactionRepositoryProtocol

    init(repository: TransactionRepositoryProtocol) {
        self.repository = repository
    }

    public override func execute(input value: Any?) {
        guard let uuid = value as? String else {
            result?(.failed(RequestDomainException.inputException))
            return
        }
        repository.deleteTransaction(with: uuid)
        result?(.success(true))
    }
}
