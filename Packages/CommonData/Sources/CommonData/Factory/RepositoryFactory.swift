import Domain

public struct RepositoryFactory: RepositoryProtocolFactory {
    public var accountRepository: AccountRepositoryProtocol
    public var transactionRepository: TransactionRepositoryProtocol

    public init(database: CoreDataServiceProtocol) {
        accountRepository = AccountsRepository(datasource: .init(database: database))
        transactionRepository = TransactionRepository(datasource: .init(database: database))
    }
}
