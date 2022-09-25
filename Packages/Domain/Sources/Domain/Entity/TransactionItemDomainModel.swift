import Foundation

public struct TransactionItemDomainModel {
    public let uuid: String
    public let toAccountUuid: String
    public let toAccountName: String
    public let fromAccountUuid: String
    public let fromAccountName: String
    public let amount: Double
    public let date: Date?
    public let comment: String?
    public let type: String

    public init(
        uuid: String,
        toAccountUuid: String,
        toAccountName: String,
        fromAccountUuid: String,
        fromAccountName: String,
        amount: Double,
        date: Date?,
        comment: String?,
        type: String
    ) {
        self.uuid = uuid
        self.toAccountUuid = toAccountUuid
        self.toAccountName = toAccountName
        self.fromAccountUuid = fromAccountUuid
        self.fromAccountName = fromAccountName
        self.amount = amount
        self.date = date
        self.comment = comment
        self.type = type
    }
}
