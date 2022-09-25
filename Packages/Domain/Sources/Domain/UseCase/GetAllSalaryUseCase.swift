import Foundation

public class GetAllSalaryUseCase: BaseUseCase {
    let repository: TransactionRepositoryProtocol

    init(repository: TransactionRepositoryProtocol) {
        self.repository = repository
    }

    public override func execute(input value: Any?) {
        repository.getAllSalary(for: value as? Date) { [weak self] expenses in
            self?.result?(.success(expenses))
        }
    }
}
