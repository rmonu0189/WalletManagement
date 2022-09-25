import UIKit

class MenuView: BaseView {
    private var iconImageView: UIImageView!
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

    override func setupUI(with item: Any) {
        guard let uiModel = item as? UiModel else { return }
        iconImageView.image = UIImage(systemName: uiModel.icon)
        titleLabel.text = uiModel.title
    }
}

extension MenuView {
    private func initializeUI() {
        backgroundColor = .clear

        iconImageView = .init(frame: .zero)
        iconImageView.tintColor = tintColor
        iconImageView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(iconImageView)

        titleLabel = .init(style: .title)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        addSubview(titleLabel)
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
            titleLabel.leadingAnchor.constraint(equalTo: iconImageView.trailingAnchor, constant: 16),
            titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            titleLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -20)
        ])
    }
}

extension MenuView {
    struct UiModel {
        let icon: String
        let title: String
    }
}
