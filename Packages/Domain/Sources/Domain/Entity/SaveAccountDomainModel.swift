public struct SaveAccountDomainModel {
    public let name: String
    public let type: String
    public let initialAmount: Double?
    public let last4Digit: String?
    public let jsonData: String?

    public init(name: String, type: String, initialAmount: Double?, last4Digit: String?, jsonData: String? = nil) {
        self.name = name
        self.type = type
        self.initialAmount = initialAmount
        self.last4Digit = last4Digit
        self.jsonData = jsonData
    }
}
