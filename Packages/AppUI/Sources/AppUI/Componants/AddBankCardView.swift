import UIKit
import Domain

class AddBankCardView: UIView {
    private var bankNameTextField: StyleTextField!
    private var cardNumberTextField: StyleTextField!
    private var expiryTextField: StyleTextField!
    private var cvvTextField: StyleTextField!
    private var nameOnCardTextField: StyleTextField!
    private var initialAmountTextField: StyleTextField!
    private var saveButton: CTAButtonView!
    private var cardType: String = AccountType.CreditCard.rawValue
    private var bankUuid: String?

    public var saveAction: ((BankCardDomainModel) -> Void)?

    override init(frame: CGRect) {
        super.init(frame: frame)
        initializeUI()
        addConstraints()
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    public func setupUI(with uiModel: UiModel) {
        if uiModel.bankAccount != nil {
            cardType = AccountType.DebitCard.rawValue
            bankUuid = uiModel.bankAccount?.uuid
            bankNameTextField.text = uiModel.bankAccount?.name
            bankNameTextField.isEnabled = false
        } else {
            cardType = AccountType.CreditCard.rawValue
            bankNameTextField.text = ""
            bankNameTextField.isEnabled = true
        }
    }

    private func saveTapped() {
        saveAction?(.init(
            bankName: bankNameTextField.trimText,
            cardNumber: cardNumberTextField.trimText,
            expiryDate: expiryTextField.trimText,
            cvv: cvvTextField.trimText,
            nameOnCard: nameOnCardTextField.trimText,
            cardType: cardType,
            bankUuid: bankUuid,
            initialAmount: Double(initialAmountTextField.trimText)
        ))
    }
}

extension AddBankCardView {
    private func initializeUI() {
        bankNameTextField = .init(style: .title, placeholder: "Bank name")
        bankNameTextField.translatesAutoresizingMaskIntoConstraints = false
        bankNameTextField.autocapitalizationType = .words
        bankNameTextField.returnKeyType = .next
        bankNameTextField.delegate = self
        addSubview(bankNameTextField)

        cardNumberTextField = .init(style: .title, placeholder: "Card number")
        cardNumberTextField.translatesAutoresizingMaskIntoConstraints = false
        cardNumberTextField.autocapitalizationType = .words
        cardNumberTextField.returnKeyType = .next
        cardNumberTextField.delegate = self
        addSubview(cardNumberTextField)

        expiryTextField = .init(style: .title, placeholder: "Expiry Date")
        expiryTextField.translatesAutoresizingMaskIntoConstraints = false
        expiryTextField.autocapitalizationType = .allCharacters
        expiryTextField.returnKeyType = .next
        expiryTextField.delegate = self
        addSubview(expiryTextField)

        cvvTextField = .init(style: .title, placeholder: "CVV")
        cvvTextField.translatesAutoresizingMaskIntoConstraints = false
        cvvTextField.autocapitalizationType = .allCharacters
        cvvTextField.returnKeyType = .next
        cvvTextField.delegate = self
        addSubview(cvvTextField)

        nameOnCardTextField = .init(style: .title, placeholder: "Name on card")
        nameOnCardTextField.translatesAutoresizingMaskIntoConstraints = false
        nameOnCardTextField.autocapitalizationType = .words
        nameOnCardTextField.returnKeyType = .next
        nameOnCardTextField.delegate = self
        addSubview(nameOnCardTextField)

        initialAmountTextField = .init(style: .title, placeholder: "Initial amount")
        initialAmountTextField.translatesAutoresizingMaskIntoConstraints = false
        initialAmountTextField.returnKeyType = .done
        initialAmountTextField.delegate = self
        initialAmountTextField.addToolBar(nil, rightButtonTitle: "Done")
        addSubview(initialAmountTextField)

        saveButton = .init(frame: .zero)
        saveButton.setupUI(with: .init(title: "Save"))
        saveButton.action = { [weak self] in
            self?.saveTapped()
        }
        saveButton.translatesAutoresizingMaskIntoConstraints = false
        saveButton.isEnable = true
        addSubview(saveButton)
    }

    private func addConstraints() {
        NSLayoutConstraint.activate([
            bankNameTextField.heightAnchor.constraint(equalToConstant: 50),
            bankNameTextField.topAnchor.constraint(equalTo: topAnchor, constant: 8),
            bankNameTextField.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            bankNameTextField.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20)
        ])
    
        NSLayoutConstraint.activate([
            cardNumberTextField.heightAnchor.constraint(equalToConstant: 50),
            cardNumberTextField.topAnchor.constraint(equalTo: bankNameTextField.bottomAnchor, constant: 20),
            cardNumberTextField.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            cardNumberTextField.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20)
        ])

        NSLayoutConstraint.activate([
            expiryTextField.heightAnchor.constraint(equalToConstant: 50),
            expiryTextField.topAnchor.constraint(equalTo: cardNumberTextField.bottomAnchor, constant: 20),
            expiryTextField.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            expiryTextField.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20)
        ])

        NSLayoutConstraint.activate([
            cvvTextField.heightAnchor.constraint(equalToConstant: 50),
            cvvTextField.topAnchor.constraint(equalTo: expiryTextField.bottomAnchor, constant: 20),
            cvvTextField.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            cvvTextField.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20)
        ])

        NSLayoutConstraint.activate([
            nameOnCardTextField.heightAnchor.constraint(equalToConstant: 50),
            nameOnCardTextField.topAnchor.constraint(equalTo: cvvTextField.bottomAnchor, constant: 20),
            nameOnCardTextField.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            nameOnCardTextField.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20)
        ])

        NSLayoutConstraint.activate([
            initialAmountTextField.heightAnchor.constraint(equalToConstant: 50),
            initialAmountTextField.topAnchor.constraint(equalTo: nameOnCardTextField.bottomAnchor, constant: 20),
            initialAmountTextField.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            initialAmountTextField.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20)
        ])

        NSLayoutConstraint.activate([
            saveButton.topAnchor.constraint(equalTo: initialAmountTextField.bottomAnchor, constant: 20),
            saveButton.leadingAnchor.constraint(equalTo: leadingAnchor),
            saveButton.trailingAnchor.constraint(equalTo: trailingAnchor),
            saveButton.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -20)
        ])
    }
}

extension AddBankCardView: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if textField == initialAmountTextField, textField.text?.contains(".") == true, string.contains(".") {
            return false
        }
        return true
    }

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == bankNameTextField {
            cardNumberTextField.becomeFirstResponder()
        } else if textField == cardNumberTextField {
            expiryTextField.becomeFirstResponder()
        } else if textField == expiryTextField {
            cvvTextField.becomeFirstResponder()
        } else if textField == cvvTextField {
            nameOnCardTextField.becomeFirstResponder()
        } else if textField == nameOnCardTextField {
            initialAmountTextField.becomeFirstResponder()
        }
        return true
    }
}

extension AddBankCardView {
    struct UiModel {
        let bankAccount: AccountDomainModel?
    }
}

class AddBankCardViewCard: CardItem<ViewWrapperCell<AddBankCardView>> {
    private let bankAccount: AccountDomainModel?
    private let saveAction: ((BankCardDomainModel) -> Void)?

    init(bankAccount: AccountDomainModel? = nil, saveAction: ((BankCardDomainModel) -> Void)?) {
        self.bankAccount = bankAccount
        self.saveAction = saveAction
    }

    override func cellFor(_ collectionView: UICollectionView, indexPath: IndexPath) -> UICollectionViewCell {
        let cell: ViewWrapperCell<AddBankCardView> = collectionView.dequeueReusableCell(for: indexPath)
        cell.view.setupUI(with: .init(bankAccount: bankAccount))
        cell.view.saveAction = saveAction
        return cell
    }
}
