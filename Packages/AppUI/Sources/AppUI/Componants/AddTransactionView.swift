import UIKit
import Domain

class AddTransactionView: UIView {
    private var accountTextField: StyleTextField!
    private var fromAccountTextField: StyleTextField!
    private var amountTextField: StyleTextField!
    private var dateTextField: StyleTextField!
    private var commentTextField: StyleTextField!
    private var saveButton: CTAButtonView!
    private let dateFormatter: DateFormatter = .init()

    public var toAccount: AccountDomainModel?
    public var fromAccount: AccountDomainModel?

    public var saveAction: ((TransactionDomainModel) -> Void)?

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
        accountTextField.enableCustomPicker(
            uiModel.toAccounts.compactMap({"\($0.name) - \($0.displaySubtitle)"})
        ) { [weak self] index in
            self?.toAccount = uiModel.toAccounts[index]
            self?.accountTextField.text = "\(self?.toAccount?.name ?? "") - \(self?.toAccount?.type ?? "")"
        }
        
        fromAccountTextField.enableCustomPicker(
            uiModel.fromAccounts.compactMap({"\($0.name) - \($0.displaySubtitle)"})
        ) { [weak self] index in
            self?.fromAccount = uiModel.fromAccounts[index]
            self?.fromAccountTextField.text = "\(self?.fromAccount?.name ?? "") - \(self?.fromAccount?.type ?? "")"
        }
    }

    private func saveTapped() {
        guard let toAccount = toAccount else { return }
        guard let fromAccount = fromAccount else { return }
        guard let amount = Double(amountTextField.trimText) else { return }
        guard let date = dateFormatter.date(from: dateTextField.trimText) else { return }
        saveAction?(.init(
            toAccount: toAccount,
            fromAccount: fromAccount,
            amount: amount,
            date: date,
            comment: commentTextField.trimText
        ))
    }
}

extension AddTransactionView {
    private func initializeUI() {
        dateFormatter.dateFormat = "dd/MM/yyyy"

        accountTextField = .init(style: .title, placeholder: "To Account")
        accountTextField.translatesAutoresizingMaskIntoConstraints = false
        accountTextField.autocapitalizationType = .words
        accountTextField.returnKeyType = .next
        addSubview(accountTextField)

        fromAccountTextField = .init(style: .title, placeholder: "From Account")
        fromAccountTextField.translatesAutoresizingMaskIntoConstraints = false
        fromAccountTextField.autocapitalizationType = .words
        fromAccountTextField.returnKeyType = .next
        addSubview(fromAccountTextField)

        amountTextField = .init(style: .title, placeholder: "Amount")
        amountTextField.translatesAutoresizingMaskIntoConstraints = false
        amountTextField.autocapitalizationType = .words
        amountTextField.returnKeyType = .next
        amountTextField.keyboardType = .decimalPad
        amountTextField.delegate = self
        amountTextField.addToolBar(nil, rightButtonTitle: "Done")
        addSubview(amountTextField)

        dateTextField = .init(style: .title, placeholder: "Date")
        dateTextField.translatesAutoresizingMaskIntoConstraints = false
        dateTextField.autocapitalizationType = .words
        dateTextField.returnKeyType = .next
        dateTextField.text = dateFormatter.string(from: Date())
        dateTextField.enableDatePicker { [weak self] date in
            self?.dateTextField.text = self?.dateFormatter.string(from: date)
        }
        addSubview(dateTextField)

        commentTextField = .init(style: .title, placeholder: "Comment")
        commentTextField.translatesAutoresizingMaskIntoConstraints = false
        commentTextField.autocapitalizationType = .words
        commentTextField.returnKeyType = .done
        commentTextField.delegate = self
        addSubview(commentTextField)
        
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
            accountTextField.heightAnchor.constraint(equalToConstant: 50),
            accountTextField.topAnchor.constraint(equalTo: topAnchor, constant: 8),
            accountTextField.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            accountTextField.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20)
        ])
        
        NSLayoutConstraint.activate([
            fromAccountTextField.heightAnchor.constraint(equalToConstant: 50),
            fromAccountTextField.topAnchor.constraint(equalTo: accountTextField.bottomAnchor, constant: 20),
            fromAccountTextField.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            fromAccountTextField.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20)
        ])

        NSLayoutConstraint.activate([
            amountTextField.heightAnchor.constraint(equalToConstant: 50),
            amountTextField.topAnchor.constraint(equalTo: fromAccountTextField.bottomAnchor, constant: 20),
            amountTextField.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            amountTextField.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20)
        ])

        NSLayoutConstraint.activate([
            dateTextField.heightAnchor.constraint(equalToConstant: 50),
            dateTextField.topAnchor.constraint(equalTo: amountTextField.bottomAnchor, constant: 20),
            dateTextField.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            dateTextField.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20)
        ])

        NSLayoutConstraint.activate([
            commentTextField.heightAnchor.constraint(equalToConstant: 50),
            commentTextField.topAnchor.constraint(equalTo: dateTextField.bottomAnchor, constant: 20),
            commentTextField.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            commentTextField.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20)
        ])

        NSLayoutConstraint.activate([
            saveButton.topAnchor.constraint(equalTo: commentTextField.bottomAnchor, constant: 20),
            saveButton.leadingAnchor.constraint(equalTo: leadingAnchor),
            saveButton.trailingAnchor.constraint(equalTo: trailingAnchor),
            saveButton.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -20)
        ])
    }
}

extension AddTransactionView: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if textField == amountTextField, textField.text?.contains(".") == true, string.contains(".") {
            return false
        }
        return true
    }

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}

extension AddTransactionView {
    struct UiModel {
        let toAccounts: [AccountDomainModel]
        let fromAccounts: [AccountDomainModel]

        init(toAccounts: [AccountDomainModel], fromAccounts: [AccountDomainModel]) {
            self.toAccounts = toAccounts
            self.fromAccounts = fromAccounts
        }
    }
}

class AddTransactionViewCard: CardItem<ViewWrapperCell<AddTransactionView>> {
    private var toAccounts: [AccountDomainModel] = []
    private var fromAccounts: [AccountDomainModel] = []
    private var saveAction: ((TransactionDomainModel) -> Void)?

    init(
        toAccounts: [AccountDomainModel],
        fromAccounts: [AccountDomainModel],
        saveAction: ((TransactionDomainModel) -> Void)?
    ) {
        self.toAccounts = toAccounts
        self.fromAccounts = fromAccounts
        self.saveAction = saveAction
    }

    override func cellFor(_ collectionView: UICollectionView, indexPath: IndexPath) -> UICollectionViewCell {
        let cell: ViewWrapperCell<AddTransactionView> = collectionView.dequeueReusableCell(for: indexPath)
        cell.view.setupUI(with: .init(toAccounts: toAccounts, fromAccounts: fromAccounts))
        cell.view.saveAction = saveAction
        return cell
    }
}
