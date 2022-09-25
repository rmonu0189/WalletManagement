import Foundation

public struct TransactionDomainModel {
    public let toAccount: AccountDomainModel
    public let fromAccount: AccountDomainModel
    public let amount: Double
    public let date: Date
    public let comment: String?

    public init(
        toAccount: AccountDomainModel,
        fromAccount: AccountDomainModel,
        amount: Double,
        date: Date,
        comment: String?
    ) {
        self.toAccount = toAccount
        self.fromAccount = fromAccount
        self.amount = amount
        self.date = date
        self.comment = comment
    }
}
