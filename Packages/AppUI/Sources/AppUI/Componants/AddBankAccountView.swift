import UIKit
import Domain

class AddBankAccountView: UIView {
    private var bankNameTextField: StyleTextField!
    private var accountNumberTextField: StyleTextField!
    private var ifscTextField: StyleTextField!
    private var nameTextField: StyleTextField!
    private var initialAmountTextField: StyleTextField!
    private var saveButton: CTAButtonView!

    public var saveAction: ((BankAccountDomainModel) -> Void)?

    override init(frame: CGRect) {
        super.init(frame: frame)
        initializeUI()
        addConstraints()
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func saveTapped() {
        saveAction?(.init(
            bankName: bankNameTextField.trimText,
            accountNumber: accountNumberTextField.trimText,
            ifscCode: ifscTextField.trimText,
            accountHolderName: nameTextField.trimText,
            initialAmount: Double(initialAmountTextField.trimText)
        ))
    }
}

extension AddBankAccountView {
    private func initializeUI() {
        bankNameTextField = .init(style: .title, placeholder: "Bank name")
        bankNameTextField.translatesAutoresizingMaskIntoConstraints = false
        bankNameTextField.autocapitalizationType = .words
        bankNameTextField.returnKeyType = .next
        bankNameTextField.delegate = self
        addSubview(bankNameTextField)

        accountNumberTextField = .init(style: .title, placeholder: "Account number")
        accountNumberTextField.translatesAutoresizingMaskIntoConstraints = false
        accountNumberTextField.autocapitalizationType = .words
        accountNumberTextField.returnKeyType = .next
        accountNumberTextField.delegate = self
        addSubview(accountNumberTextField)

        ifscTextField = .init(style: .title, placeholder: "IFSC Code")
        ifscTextField.translatesAutoresizingMaskIntoConstraints = false
        ifscTextField.autocapitalizationType = .allCharacters
        ifscTextField.returnKeyType = .next
        ifscTextField.delegate = self
        addSubview(ifscTextField)

        nameTextField = .init(style: .title, placeholder: "Account holder name")
        nameTextField.translatesAutoresizingMaskIntoConstraints = false
        nameTextField.autocapitalizationType = .words
        nameTextField.returnKeyType = .next
        nameTextField.delegate = self
        addSubview(nameTextField)

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
            accountNumberTextField.heightAnchor.constraint(equalToConstant: 50),
            accountNumberTextField.topAnchor.constraint(equalTo: bankNameTextField.bottomAnchor, constant: 20),
            accountNumberTextField.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            accountNumberTextField.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20)
        ])

        NSLayoutConstraint.activate([
            ifscTextField.heightAnchor.constraint(equalToConstant: 50),
            ifscTextField.topAnchor.constraint(equalTo: accountNumberTextField.bottomAnchor, constant: 20),
            ifscTextField.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            ifscTextField.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20)
        ])

        NSLayoutConstraint.activate([
            nameTextField.heightAnchor.constraint(equalToConstant: 50),
            nameTextField.topAnchor.constraint(equalTo: ifscTextField.bottomAnchor, constant: 20),
            nameTextField.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            nameTextField.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20)
        ])

        NSLayoutConstraint.activate([
            initialAmountTextField.heightAnchor.constraint(equalToConstant: 50),
            initialAmountTextField.topAnchor.constraint(equalTo: nameTextField.bottomAnchor, constant: 20),
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

extension AddBankAccountView: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if textField == initialAmountTextField, textField.text?.contains(".") == true, string.contains(".") {
            return false
        }
        return true
    }

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == bankNameTextField {
            accountNumberTextField.becomeFirstResponder()
        } else if textField == accountNumberTextField {
            ifscTextField.becomeFirstResponder()
        } else if textField == ifscTextField {
            nameTextField.becomeFirstResponder()
        } else if textField == nameTextField {
            initialAmountTextField.becomeFirstResponder()
        }
        return true
    }
}

class AddBankAccountViewCard: CardItem<ViewWrapperCell<AddBankAccountView>> {
    private let saveAction: ((BankAccountDomainModel) -> Void)?

    init(saveAction: ((BankAccountDomainModel) -> Void)?) {
        self.saveAction = saveAction
    }

    override func cellFor(_ collectionView: UICollectionView, indexPath: IndexPath) -> UICollectionViewCell {
        let cell: ViewWrapperCell<AddBankAccountView> = collectionView.dequeueReusableCell(for: indexPath)
        cell.view.saveAction = saveAction
        return cell
    }
}
