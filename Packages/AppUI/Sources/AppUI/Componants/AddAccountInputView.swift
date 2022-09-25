import UIKit

class AddAccountInputView: UIView {
    private var nameTextField: StyleTextField!
    private var initialAmountTextField: StyleTextField!
    private var saveButton: CTAButtonView!

    public var saveAction: ((String, Double) -> Void)?

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
        saveAction?(nameTextField.trimText, Double(initialAmountTextField.trimText) ?? 0)
    }
}

extension AddAccountInputView {
    private func initializeUI() {
        nameTextField = .init(style: .title, placeholder: "Account name")
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
            nameTextField.heightAnchor.constraint(equalToConstant: 50),
            nameTextField.topAnchor.constraint(equalTo: topAnchor, constant: 8),
            nameTextField.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            nameTextField.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20)
        ])

        NSLayoutConstraint.activate([
            initialAmountTextField.heightAnchor.constraint(equalToConstant: 50),
            initialAmountTextField.topAnchor.constraint(equalTo: nameTextField.bottomAnchor, constant: 16),
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

extension AddAccountInputView: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if textField == initialAmountTextField, textField.text?.contains(".") == true, string.contains(".") {
            return false
        }
        return true
    }

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == nameTextField {
            initialAmountTextField.becomeFirstResponder()
        }
        return true
    }
}

class AddAccountInputViewCard: CardItem<ViewWrapperCell<AddAccountInputView>> {
    private let saveAction: ((String, Double) -> Void)?

    init(saveAction: ((String, Double) -> Void)?) {
        self.saveAction = saveAction
    }

    override func cellFor(_ collectionView: UICollectionView, indexPath: IndexPath) -> UICollectionViewCell {
        let cell: ViewWrapperCell<AddAccountInputView> = collectionView.dequeueReusableCell(for: indexPath)
        cell.view.saveAction = saveAction
        return cell
    }
}
