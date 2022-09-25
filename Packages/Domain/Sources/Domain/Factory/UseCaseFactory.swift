public class UseCaseFactory {
    let repositoryFactory: RepositoryProtocolFactory

    public init(repositoryFactory: RepositoryProtocolFactory) {
        self.repositoryFactory = repositoryFactory
    }

    public lazy var saveAccountUseCase: SaveAccountUseCase = {
        .init(repository: repositoryFactory.accountRepository)
    }()

    public lazy var getAllAccountsUseCase: GetAllAccountsUseCase = {
        .init(repository: repositoryFactory.accountRepository)
    }()

    public lazy var getAllSavingAccountUseCase: GetAllSavingAccountUseCase = {
        .init(repository: repositoryFactory.accountRepository)
    }()

    public lazy var saveTransactionUseCase: SaveTransactionUseCase = {
        .init(repository: repositoryFactory.transactionRepository)
    }()

    public lazy var getAllExpensesUseCase: GetAllExpensesUseCase = {
        .init(repository: repositoryFactory.transactionRepository)
    }()

    public lazy var getAccountTransactionsUseCase: GetAccountTransactionsUseCase = {
        .init(repository: repositoryFactory.transactionRepository)
    }()

    public lazy var getAllExpendituresUseCase: GetAllExpendituresUseCase = {
        .init(repository: repositoryFactory.transactionRepository)
    }()

    public lazy var getMyFinanceAccountsUseCase: GetMyFinanceAccountsUseCase = {
        .init(repository: repositoryFactory.accountRepository)
    }()
    
    public lazy var getAllSalaryUseCase: GetAllSalaryUseCase = {
        .init(repository: repositoryFactory.transactionRepository)
    }()

    public lazy var getAllTransactionsUseCase: GetAllTransactionsUseCase = {
        .init(repository: repositoryFactory.transactionRepository)
    }()

    public lazy var deleteTransactionUseCase: DeleteTransactionUseCase = {
        .init(repository: repositoryFactory.transactionRepository)
    }()
}
