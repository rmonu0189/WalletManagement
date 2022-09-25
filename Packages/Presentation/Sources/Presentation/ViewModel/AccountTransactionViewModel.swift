import Domain
import CommonUtility

public class AccountTransactionViewModel: AccountTransactionViewModelProtocol {
    public var allTransactions: Bindable<[TransactionItemDomainModel]> = Bindable([])
    public var accountDomainModel: AccountDomainModel
    
    private let useCaseExecutor: UseCaseExecutor
    private let getAccountTransactionsUseCase: GetAccountTransactionsUseCase
    private let deleteTransactionUseCase: DeleteTransactionUseCase

    public init(
        accountDomainModel: AccountDomainModel,
        useCaseExecutor: UseCaseExecutor,
        getAccountTransactionsUseCase: GetAccountTransactionsUseCase,
        deleteTransactionUseCase: DeleteTransactionUseCase
    ) {
        self.accountDomainModel = accountDomainModel
        self.useCaseExecutor = useCaseExecutor
        self.getAccountTransactionsUseCase = getAccountTransactionsUseCase
        self.deleteTransactionUseCase = deleteTransactionUseCase
    }

    public func getTransactions() {
        useCaseExecutor.execute(
            useCase: getAccountTransactionsUseCase,
            input: accountDomainModel.uuid
        ) { [weak self] result in
            guard let transactions = result as? [TransactionItemDomainModel] else { return }
            self?.allTransactions.update(with: transactions)
        } failed: { error in
            AppLogger.log(error)
        }
    }

    public func deleteTransaction(at index: Int) {
        let uuid = allTransactions.value[index].uuid
        useCaseExecutor.execute(
            useCase: deleteTransactionUseCase,
            input: uuid
        ) { [weak self] _ in
            self?.getTransactions()
        } failed: { error in
            AppLogger.log(error)
        }
    }
}
