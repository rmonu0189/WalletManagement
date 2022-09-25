import Domain
import Foundation

struct AccountsRepository: AccountRepositoryProtocol {
    let datasource: AccountsLocalDataSources

    init(datasource: AccountsLocalDataSources) {
        self.datasource = datasource
    }

    func saveAccount(with model: SaveAccountDomainModel) {
        datasource.saveAccount(.init(
            uuid: UUID().uuidString,
            name: model.name,
            type: model.type,
            balance: model.initialAmount ?? 0,
            dueDate: nil,
            jsonData: model.jsonData,
            last4Digit: model.last4Digit
        ))
    }

    func getAllAccounts(handler: ([AccountDomainModel]) -> Void) {
        handler(datasource.getAllAccounts())
    }

    func getMyFinanceAccounts(handler: ([AccountDomainModel]) -> Void) {
        handler(datasource.getMyFinanceAccounts())
    }
}
