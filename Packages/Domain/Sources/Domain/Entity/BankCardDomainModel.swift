import Foundation

public struct BankCardDomainModel: Codable {
    public let bankName: String
    public let cardNumber: String
    public let expiryDate: String
    public let cvv: String
    public let nameOnCard: String
    public let cardType: String
    public let bankUuid: String?
    public let initialAmount: Double?

    public init(
        bankName: String,
        cardNumber: String,
        expiryDate: String,
        cvv: String,
        nameOnCard: String,
        cardType: String,
        bankUuid: String?,
        initialAmount: Double?
    ) {
        self.bankName = bankName
        self.cardNumber = cardNumber
        self.expiryDate = expiryDate
        self.cvv = cvv
        self.nameOnCard = nameOnCard
        self.cardType = cardType
        self.bankUuid = bankUuid
        self.initialAmount = initialAmount
    }
}
