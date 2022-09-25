import UIKit

class StatisticsBarView: UIView {
    private var nameLabel: UILabel!
    private var amountLabel: UILabel!
    private var progressBar: ProgressStatusBar!

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
        progressBar.setProgress(uiModel.percentage, color: uiModel.color)
        nameLabel.text = uiModel.name
        amountLabel.text = String(format: "₹%0.2f", uiModel.amount)
    }
}

extension StatisticsBarView {
    private func initializeUI() {
        nameLabel = .init(style: .heading3)
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        addSubview(nameLabel)

        amountLabel = .init(style: .heading3)
        amountLabel.translatesAutoresizingMaskIntoConstraints = false
        addSubview(amountLabel)

        progressBar = .init(frame: .zero)
        progressBar.cornerRadius = 4
        progressBar.clipsToBounds = true
        progressBar.translatesAutoresizingMaskIntoConstraints = false
        addSubview(progressBar)
    }

    private func addConstraints() {
        NSLayoutConstraint.activate([
            nameLabel.topAnchor.constraint(equalTo: topAnchor, constant: 12),
            nameLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 12)
        ])

        NSLayoutConstraint.activate([
            amountLabel.topAnchor.constraint(equalTo: topAnchor, constant: 12),
            amountLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -12),
            amountLabel.leadingAnchor.constraint(greaterThanOrEqualTo: nameLabel.trailingAnchor, constant: 12)
        ])

        NSLayoutConstraint.activate([
            progressBar.heightAnchor.constraint(equalToConstant: 20),
            progressBar.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 8),
            progressBar.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 12),
            progressBar.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -12),
            progressBar.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -8)
        ])
    }
}

extension StatisticsBarView {
    struct UiModel {
        let name: String
        let amount: Double
        let percentage: Double
        let color: UIColor?
    }
}

class ProgressStatusBar: UIView {
    private var barView: UIView!
    private var barWidthConstraint: NSLayoutConstraint!

    override init(frame: CGRect) {
        super.init(frame: frame)
        initializeUI()
        addConstraints()
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // Value should be 0.0 to 1.0
    public func setProgress(_ value: Double, color: UIColor?) {
        DispatchQueue.main.async {
            if value > 0 {
                let width = self.frame.width * value
                self.barView.backgroundColor = color
                self.barWidthConstraint.constant = width
            } else {
                self.barWidthConstraint.constant = 0
            }
        }
    }
}

extension ProgressStatusBar {
    private func initializeUI() {
        backgroundColor = tintColor.withAlphaComponent(0.3)

        barView = .init(frame: .zero)
        barView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(barView)
    }

    private func addConstraints() {
        NSLayoutConstraint.activate([
            barView.topAnchor.constraint(equalTo: topAnchor),
            barView.leadingAnchor.constraint(equalTo: leadingAnchor),
            barView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
        barWidthConstraint = barView.widthAnchor.constraint(equalToConstant: 0)
        barWidthConstraint.isActive = true
    }
}
