import Foundation

public struct BankAccountDomainModel: Codable {
    public let bankName: String
    public let accountNumber: String
    public let ifscCode: String
    public let accountHolderName: String
    public let initialAmount: Double?

    public init(
        bankName: String,
        accountNumber: String,
        ifscCode: String,
        accountHolderName: String,
        initialAmount: Double?
    ) {
        self.bankName = bankName
        self.accountNumber = accountNumber
        self.ifscCode = ifscCode
        self.accountHolderName = accountHolderName
        self.initialAmount = initialAmount
    }
}
