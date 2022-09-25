import Foundation

public class GetAllExpensesUseCase: BaseUseCase {
    let repository: TransactionRepositoryProtocol

    init(repository: TransactionRepositoryProtocol) {
        self.repository = repository
    }

    public override func execute(input value: Any?) {
        repository.getAllExpenses(for: value as? Date) { [weak self] expenses in
            self?.result?(.success(expenses))
        }
    }
}
