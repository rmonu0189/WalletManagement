public class SaveTransactionUseCase: BaseUseCase {
    let repository: TransactionRepositoryProtocol

    init(repository: TransactionRepositoryProtocol) {
        self.repository = repository
    }

    public override func execute(input value: Any?) {
        guard let input = value as? TransactionDomainModel else {
            result?(.failed(RequestDomainException.inputException))
            return
        }
        repository.saveTransaction(with: input)
        result?(.success(true))
    }
}
