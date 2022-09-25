import CommonData
import Domain

let appDiContainer: DIContainer = .init()

class DIContainer {
    let database = CoreDataService(databaseName: "WalletManager")
    let useCaseExecutor: UseCaseExecutor = .init()

    lazy var useCaseFactory: UseCaseFactory = {
        .init(repositoryFactory: RepositoryFactory(database: database))
    }()
}
