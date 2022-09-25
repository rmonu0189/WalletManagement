public class SaveAccountUseCase: BaseUseCase {
    let repository: AccountRepositoryProtocol

    init(repository: AccountRepositoryProtocol) {
        self.repository = repository
    }

    public override func execute(input value: Any?) {
        guard let input = value as? SaveAccountDomainModel else {
            result?(.failed(RequestDomainException.inputException))
            return
        }
        repository.saveAccount(with: input)
        result?(.success(true))
    }
}
