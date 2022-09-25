import Foundation

public struct Expenditures {
    public let title: String
    public let totalAmount: Double
    public let maxAmount: Double
    public let expensesAmount: Double
    public let loanAmount: Double
    public let investmentAmount: Double
    public let insuranceAmount: Double

    public init(
        title: String,
        totalAmount: Double,
        maxAmount: Double,
        expensesAmount: Double,
        loanAmount: Double,
        investmentAmount: Double,
        insuranceAmount: Double
    ) {
        self.title = title
        self.totalAmount = totalAmount
        self.maxAmount = maxAmount
        self.expensesAmount = expensesAmount
        self.loanAmount = loanAmount
        self.investmentAmount = investmentAmount
        self.insuranceAmount = insuranceAmount
    }
}
