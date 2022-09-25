import Domain
import Foundation

struct TransactionLocalDataSources {
    let database: CoreDataServiceProtocol

    public init(database: CoreDataServiceProtocol) {
        self.database = database
    }

    func saveTransaction(_ transaction: TransactionDomainModel) {
        let toAccountUUID = transaction.toAccount.uuid
        var fromAccountUUID = transaction.fromAccount.uuid
        if transaction.fromAccount.type == "Debit Card", let uuid = transaction.fromAccount.bankCard?.bankUuid {
            fromAccountUUID = uuid
        }

        let toAccount: AccountDatabaseModel? = database.getRecord(for: toAccountUUID)
        let fromAccount: AccountDatabaseModel? = database.getRecord(for: fromAccountUUID)
        toAccount?.balance += transaction.amount
        fromAccount?.balance -= transaction.amount

        let newTransaction: TransactionDatabaseModel = database.createModel()
        newTransaction.uuid = UUID().uuidString
        newTransaction.toAccountUuid = transaction.toAccount.uuid
        newTransaction.toAccountName = transaction.toAccount.displayName
        newTransaction.fromAccountUuid = transaction.fromAccount.uuid
        newTransaction.fromAccountName = transaction.fromAccount.displayName
        newTransaction.amount = transaction.amount
        newTransaction.date = transaction.date
        newTransaction.comment = transaction.comment
        if transaction.fromAccount.type == "Salary" {
            newTransaction.type = "Salary"
        } else {
            newTransaction.type = transaction.toAccount.type
        }
        newTransaction.createdAt = Date()
        newTransaction.updatedAt = Date()
        newTransaction.isSync = false
        
        database.saveContext()
    }

    func deleteTransaction(with uuid: String) {
        if let record: TransactionDatabaseModel = database.getRecord(for: uuid) {
            if let toAccountUuid = record.toAccountUuid {
                let toAccount: AccountDatabaseModel? = database.getRecord(for: toAccountUuid)
                toAccount?.balance -= record.amount
            }
            if let uuid = record.fromAccountUuid {
                let fromAccount: AccountDatabaseModel? = database.getRecord(for: uuid)
                fromAccount?.balance += record.amount
            }
            database.deleteRecord(of: record)
        }
    }

    func getAllTransactions(for month: Date?) -> [TransactionItemDomainModel] {
        var predicate: NSPredicate?
        if let month = month {
            let lastDate = month.endOfMonth
            let firstDate = month.startOfMonth
            predicate = NSPredicate(format: "date >= %@ && date <= %@", firstDate as CVarArg, lastDate as CVarArg)
        }
        let results = database.getRecords(
            TransactionDatabaseModel.self,
            predecate: predicate,
            sortDescriptors: [NSSortDescriptor(key: "createdAt", ascending: false)]
        )
        let mapper = TransactionDatabaseToDomainMapper()
        return results.compactMap({mapper.map(input: $0)})
    }

    func getAllExpenses(for month: Date?) -> [TransactionItemDomainModel] {
        var predicate: NSPredicate?
        if let month = month {
            let lastDate = month.endOfMonth
            let firstDate = month.startOfMonth
            predicate = NSPredicate(format: "date >= %@ && date <= %@", firstDate as CVarArg, lastDate as CVarArg)
        }
        let results = database.getRecords(
            TransactionDatabaseModel.self,
            predecate: predicate,
            sortDescriptors: [NSSortDescriptor(key: "createdAt", ascending: false)]
        ).filter({$0.type == "Expenses"})
        let mapper = TransactionDatabaseToDomainMapper()
        return results.compactMap({mapper.map(input: $0)})
    }

    func getAllExpenses(for accountUuid: String) -> [TransactionItemDomainModel] {
        let results = database.getRecords(
            TransactionDatabaseModel.self,
            predecate: NSPredicate(format: "toAccountUuid = %@ OR fromAccountUuid = %@", accountUuid, accountUuid),
            sortDescriptors: [NSSortDescriptor(key: "createdAt", ascending: false)]
        )
        let mapper = TransactionDatabaseToDomainMapper()
        return results.compactMap({mapper.map(input: $0)})
    }

    func getAllSalary(for month: Date?) -> [TransactionItemDomainModel] {
        var predicate: NSPredicate?
        if let month = month {
            let lastDate = month.endOfMonth
            let firstDate = month.startOfMonth
            predicate = NSPredicate(format: "date >= %@ && date <= %@", firstDate as CVarArg, lastDate as CVarArg)
        }
        let results = database.getRecords(
            TransactionDatabaseModel.self,
            predecate: predicate,
            sortDescriptors: [NSSortDescriptor(key: "createdAt", ascending: false)]
        ).filter({$0.type == "Salary" })
        let mapper = TransactionDatabaseToDomainMapper()
        return results.compactMap({mapper.map(input: $0)})
    }

    func getAllExpenditures(for month: Date?) -> [TransactionItemDomainModel] {
        var predicate: NSPredicate?
        if let month = month {
            let lastDate = month.endOfMonth
            let firstDate = month.startOfMonth
            predicate = NSPredicate(format: "date >= %@ && date <= %@", firstDate as CVarArg, lastDate as CVarArg)
        }
        let results = database.getRecords(
            TransactionDatabaseModel.self,
            predecate: predicate,
            sortDescriptors: [NSSortDescriptor(key: "createdAt", ascending: false)]
        ).filter({$0.type == "Expenses" || $0.type == "Loan" || $0.type == "Investment" || $0.type == "Insurance"})
        let mapper = TransactionDatabaseToDomainMapper()
        return results.compactMap({mapper.map(input: $0)})
    }
}
