import UIKit
import CommonUtility

class ProgressBarStatisticsView: UIView {
    private var containerView: UIView!
    private var stackView: UIStackView!
    private var titleLabel: UILabel!
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

    public func setupUI(with uiModel: UiModel) {
        titleLabel.text = uiModel.title
        amountLabel.text = String(format: "₹%0.2f", uiModel.totalAmount)
        stackView.removeAllArrangedSubviews()
        
        for item in uiModel.statistics {
            let card = StatisticsBarView(frame: .zero)
            card.translatesAutoresizingMaskIntoConstraints = false
            card.setupUI(with: item)
            stackView.addArrangedSubview(card)
        }
    }
}

extension ProgressBarStatisticsView {
    private func initializeUI() {
        containerView = .init(frame: .zero)
        containerView.cornerRadius = 8
        containerView.backgroundColor = .cardBackground
        containerView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(containerView)
    
        stackView = .init(frame: .zero)
        stackView.axis = .vertical
        stackView.distribution = .fill
        stackView.translatesAutoresizingMaskIntoConstraints = false
        containerView.addSubview(stackView)

        titleLabel = .init(style: .title)
        titleLabel.alpha = 0.7
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        containerView.addSubview(titleLabel)
    
        amountLabel = .init(style: .heading1)
        amountLabel.translatesAutoresizingMaskIntoConstraints = false
        containerView.addSubview(amountLabel)
    }

    private func addConstraints() {
        containerView.pin(to: self, insets: .init(top: 0, left: 12, bottom: 12, right: 12))
        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 24),
            titleLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 24)
        ])
        NSLayoutConstraint.activate([
            amountLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 4),
            amountLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 24)
        ])
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: amountLabel.bottomAnchor, constant: 20),
            stackView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 12),
            stackView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -12),
            stackView.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -20)
        ])
    }
}

extension ProgressBarStatisticsView {
    struct UiModel {
        let title: String
        let totalAmount: Double
        let statistics: [StatisticsBarView.UiModel]
    }
}

class ProgressBarStatisticsViewCard: CardItem<ViewWrapperCell<ProgressBarStatisticsView>> {
    private let model: ProgressBarStatisticsView.UiModel
    
    init(model: ProgressBarStatisticsView.UiModel) {
        self.model = model
    }
    
    override func cellFor(_ collectionView: UICollectionView, indexPath: IndexPath) -> UICollectionViewCell {
        let cell: ViewWrapperCell<ProgressBarStatisticsView> = collectionView.dequeueReusableCell(for: indexPath)
        cell.view.setupUI(with: model)
        return cell
    }
}
