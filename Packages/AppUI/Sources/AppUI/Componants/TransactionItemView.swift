import UIKit

class TransactionItemView: BaseView {
    private var iconImageView: UIImageView!
    private var titleLabel: UILabel!
    private var subtitleLabel: UILabel!
    private var amountLabel: UILabel!
    private var dateLabel: UILabel!

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
        guard let uiModel = item as? UiModel else { return }
        titleLabel.text = uiModel.title
        subtitleLabel.text = uiModel.subtitle
        dateLabel.text = uiModel.date
        amountLabel.text = String(format: "₹%0.2f", uiModel.amount)
        if uiModel.amount == 0 {
            amountLabel.textColor = .equalBalance
        } else if uiModel.amount > 0 {
            amountLabel.textColor = .positiveBalance
        } else {
            amountLabel.textColor = .negetiveBalance
            amountLabel.text = String(format: "-₹%0.2f", -uiModel.amount)
        }
        if let icon = AccountType(rawValue: uiModel.type)?.icon {
            iconImageView.image = UIImage(systemName: icon)
        }
    }
}

extension TransactionItemView {
    private func initializeUI() {
        iconImageView = .init(frame: .zero)
        iconImageView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(iconImageView)
        
        titleLabel = .init(style: .heading3)
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
        
        dateLabel = .init(style: .subtitle)
        dateLabel.alpha = 0.7
        dateLabel.translatesAutoresizingMaskIntoConstraints = false
        addSubview(dateLabel)
    }

    private func addConstraints() {
        NSLayoutConstraint.activate([
            iconImageView.heightAnchor.constraint(equalToConstant: 25),
            iconImageView.widthAnchor.constraint(equalToConstant: 25),
            iconImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            iconImageView.centerYAnchor.constraint(equalTo: centerYAnchor)
        ])

        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: topAnchor, constant: 20),
            titleLabel.leadingAnchor.constraint(equalTo: iconImageView.trailingAnchor, constant: 16)
        ])

        NSLayoutConstraint.activate([
            subtitleLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 4),
            subtitleLabel.leadingAnchor.constraint(equalTo: iconImageView.trailingAnchor, constant: 16),
            subtitleLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16)
        ])

        NSLayoutConstraint.activate([
            dateLabel.topAnchor.constraint(equalTo: subtitleLabel.bottomAnchor, constant: 4),
            dateLabel.leadingAnchor.constraint(equalTo: iconImageView.trailingAnchor, constant: 16),
            dateLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            dateLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -20)
        ])

        NSLayoutConstraint.activate([
            amountLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            amountLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
            amountLabel.leadingAnchor.constraint(equalTo: titleLabel.trailingAnchor, constant: 12)
        ])
    }
}

extension TransactionItemView {
    struct UiModel {
        let title: String
        let subtitle: String
        let amount: Double
        let type: String
        let date: String
    }
}
