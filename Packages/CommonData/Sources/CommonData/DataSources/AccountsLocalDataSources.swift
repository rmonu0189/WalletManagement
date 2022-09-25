import Foundation
import Domain

struct AccountsLocalDataSources {
    let database: CoreDataServiceProtocol

    public init(database: CoreDataServiceProtocol) {
        self.database = database
    }

    func saveAccount(_ model: AccountDomainModel) {
        let databaseModel: AccountDatabaseModel = database.createModel()
        databaseModel.uuid = model.uuid
        databaseModel.name = model.name
        databaseModel.type = model.type
        databaseModel.balance = model.balance
        databaseModel.dueDate = model.dueDate ?? 0
        databaseModel.jsonData = model.jsonData
        databaseModel.last4Digit = model.last4Digit
        databaseModel.createdAt = Date()
        databaseModel.updatedAt = Date()
        databaseModel.isSync = false
        database.saveContext()
    }

    func getAllAccounts() -> [AccountDomainModel] {
        let results = database.getRecords(
            AccountDatabaseModel.self,
            predecate: nil,
            sortDescriptors: [NSSortDescriptor(key: "name", ascending: true)]
        )
        return results.compactMap({AccountDomainModel(
            uuid: $0.uuid ?? UUID().uuidString,
            name: $0.name ?? "",
            type: $0.type ?? "",
            balance: $0.balance,
            dueDate: $0.dueDate,
            jsonData: $0.jsonData,
            last4Digit: $0.last4Digit
        )})
    }

    func getMyFinanceAccounts() -> [AccountDomainModel] {
        let results = database.getRecords(
            AccountDatabaseModel.self,
            predecate: NSPredicate(format: "type = %@ or type = %@ or type = %@", "Cash", "Saving Account", "Credit Card"),
            sortDescriptors: [NSSortDescriptor(key: "name", ascending: true)]
        )
        return results.compactMap({AccountDomainModel(
            uuid: $0.uuid ?? UUID().uuidString,
            name: $0.name ?? "",
            type: $0.type ?? "",
            balance: $0.balance,
            dueDate: $0.dueDate,
            jsonData: $0.jsonData,
            last4Digit: $0.last4Digit
        )})
    }
}
