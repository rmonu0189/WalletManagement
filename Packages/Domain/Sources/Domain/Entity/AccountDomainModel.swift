import Foundation
import CommonUtility

public struct AccountDomainModel {
    public let uuid: String
    public let name: String
    public let type: String
    public let balance: Double
    public let dueDate: Int32?
    public let jsonData: String?
    public let last4Digit: String?

    public var displayName: String {
        return "\(name) - \(type)"
    }

    public var displaySubtitle: String {
        if let last4Digit = last4Digit, last4Digit.count > 0 {
            return type + " | XXXX\(last4Digit)"
        }
        return type
    }

    public var bankAccount: BankAccountDomainModel? {
        toModel()
    }

    public var bankCard: BankCardDomainModel? {
        toModel()
    }

    public init(uuid: String, name: String, type: String, balance: Double, dueDate: Int32?, jsonData: String?, last4Digit: String?) {
        self.uuid = uuid
        self.name = name
        self.type = type
        self.balance = balance
        self.dueDate = dueDate
        self.jsonData = jsonData
        self.last4Digit = last4Digit
    }

    private func toModel<T: Codable>() -> T? {
        do {
            guard let inputData = jsonData?.data(using: .utf8) else { return nil }
            return try JSONDecoder().decode(T.self, from: inputData)
        } catch {
            return nil
        }
    }
}
