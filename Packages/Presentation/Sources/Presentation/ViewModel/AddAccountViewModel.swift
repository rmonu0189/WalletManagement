import CommonUtility
import Domain

public class AddAccountViewModel: AddAccountViewModelProtocol {
    private let useCaseExecutor: UseCaseExecutor
    private let saveAccountUseCase: SaveAccountUseCase
    public var bankAccount: AccountDomainModel?
    public var saveAccountSuccess: Bindable<Bool> = Bindable(false)

    public init(
        useCaseExecutor: UseCaseExecutor,
        saveAccountUseCase: SaveAccountUseCase,
        bankAccount: AccountDomainModel? = nil
    ) {
        self.useCaseExecutor = useCaseExecutor
        self.saveAccountUseCase = saveAccountUseCase
        self.bankAccount = bankAccount
    }

    public func saveAccount(with model: SaveAccountDomainModel) {
        useCaseExecutor.execute(
            useCase: saveAccountUseCase,
            input: model,
            success: { [weak self] _ in
                self?.saveAccountSuccess.update(with: true)
            }
        )
    }

    public func saveBankAccount(with model: BankAccountDomainModel) {
        saveAccount(with: .init(
            name: model.bankName,
            type: "Saving Account",
            initialAmount: model.initialAmount,
            last4Digit: model.accountNumber.last(upto: 4),
            jsonData: model.toString()
        ))
    }

    public func saveBankCard(with model: BankCardDomainModel) {
        saveAccount(with: .init(
            name: model.bankName,
            type: model.cardType,
            initialAmount: model.initialAmount,
            last4Digit: model.cardNumber.last(upto: 4),
            jsonData: model.toString()
        ))
    }
}
