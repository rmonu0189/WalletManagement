import UIKit

class PersonAccountView: BaseView {
    private var iconImageView: UIImageView!
    private var titleLabel: UILabel!
    private var subtitleLabel: UILabel!
    private var amountLabel: UILabel!

    override init(frame: CGRect) {
        super.init(frame: frame)
        initializeUI()
        addConstraints()
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func setupUI(with item: Any) {
        guard let model = item as? UiModel else { return }
        setupUI(with: model)
    }

    public func setupUI(with uiModel: UiModel) {
        iconImageView.image = uiModel.title.namedIcon()
        titleLabel.text = uiModel.title
        subtitleLabel.text = uiModel.subtitle
        amountLabel.text = String(format: "₹%0.2f", uiModel.amount)
        if uiModel.amount == 0 {
            amountLabel.textColor = .equalBalance
        } else if uiModel.amount > 0 {
            amountLabel.textColor = .positiveBalance
        } else {
            amountLabel.textColor = .negetiveBalance
            amountLabel.text = String(format: "-₹%0.2f", -uiModel.amount)
        }
    }
}

extension PersonAccountView {
    private func initializeUI() {
        backgroundColor = .clear
    
        iconImageView = .init(frame: .zero)
        iconImageView.cornerRadius = 20
        iconImageView.layer.borderWidth = 2
        iconImageView.layer.borderColor = tintColor.cgColor
        iconImageView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(iconImageView)

        titleLabel = .init(style: .heading2)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        addSubview(titleLabel)

        subtitleLabel = .init(style: .subtitle)
        subtitleLabel.alpha = 0.7
        subtitleLabel.translatesAutoresizingMaskIntoConstraints = false
        addSubview(subtitleLabel)

        amountLabel = .init(style: .heading2)
        amountLabel.textAlignment = .right
        amountLabel.translatesAutoresizingMaskIntoConstraints = false
        addSubview(amountLabel)
    }

    private func addConstraints() {
        NSLayoutConstraint.activate([
            iconImageView.heightAnchor.constraint(equalToConstant: 40),
            iconImageView.widthAnchor.constraint(equalToConstant: 40),
            iconImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            iconImageView.centerYAnchor.constraint(equalTo: centerYAnchor)
        ])

        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: topAnchor, constant: 20),
            titleLabel.leadingAnchor.constraint(equalTo: iconImageView.trailingAnchor, constant: 16),
            titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16)
        ])

        NSLayoutConstraint.activate([
            subtitleLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 4),
            subtitleLabel.leadingAnchor.constraint(equalTo: iconImageView.trailingAnchor, constant: 16),
            subtitleLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            subtitleLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -20)
        ])

        NSLayoutConstraint.activate([
            amountLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            amountLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
            amountLabel.widthAnchor.constraint(equalToConstant: 100)
        ])
    }
}

extension PersonAccountView {
    struct UiModel {
        let title: String
        let subtitle: String
        let amount: Double
    }
}

class PersonAccountCardView: BaseView {
    private var containerView: UIView!
    private var stackView: UIStackView!
    private var titleLabel: UILabel!

    override init(frame: CGRect) {
        super.init(frame: frame)
        initializeUI()
        addConstraints()
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public override func setupUI(with item: Any) {
        guard let models = item as? [PersonAccountView.UiModel] else { return }
        stackView.removeAllArrangedSubviews()
        for model in models {
            if stackView.subviews.count > 0 {
                let saperator = UIView(frame: .zero)
                saperator.translatesAutoresizingMaskIntoConstraints = false
                saperator.backgroundColor = .lightGray
                saperator.alpha = 0.2
                NSLayoutConstraint.activate([
                    saperator.heightAnchor.constraint(equalToConstant: 1)
                ])
                stackView.addArrangedSubview(saperator)
            }
            let personAccountView = PersonAccountView(frame: .zero)
            personAccountView.translatesAutoresizingMaskIntoConstraints = false
            personAccountView.setupUI(with: model)
            stackView.addArrangedSubview(personAccountView)
        }
    }

    private func initializeUI() {
        containerView = .init(frame: .zero)
        containerView.cornerRadius = 8
        containerView.backgroundColor = .cardBackground
        containerView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(containerView)

        titleLabel = .init(style: .heading1)
        titleLabel.text = "Accounts Balance"
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        containerView.addSubview(titleLabel)

        stackView = .init(frame: .zero)
        stackView.axis = .vertical
        stackView.distribution = .fill
        stackView.translatesAutoresizingMaskIntoConstraints = false
        containerView.addSubview(stackView)
    }

    private func addConstraints() {
        containerView.pin(to: self, insets: .init(top: 0, left: 12, bottom: 12, right: 12))
        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 24),
            titleLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 24)
        ])
        
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 12),
            stackView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 4),
            stackView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -4),
            stackView.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -4)
        ])
    }
}

class PersonAccountViewCard: CardItem<ViewWrapperCell<PersonAccountCardView>> {
    private let models: [PersonAccountView.UiModel]

    init(models: [PersonAccountView.UiModel]) {
        self.models = models
    }

    override func cellFor(_ collectionView: UICollectionView, indexPath: IndexPath) -> UICollectionViewCell {
        let cell: ViewWrapperCell<PersonAccountCardView> = collectionView.dequeueReusableCell(for: indexPath)
        cell.view.setupUI(with: models)
        return cell
    }
}
