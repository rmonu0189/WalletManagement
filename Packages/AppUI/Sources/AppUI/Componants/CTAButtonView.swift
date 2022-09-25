import UIKit

public class CTAButtonView: UIView {
    public var action: (() -> Void)?
    private var button: StyleButton!
    private var horizontalLine: UIView!

    public var isEnable: Bool = true {
        didSet {
            button.isEnabled = isEnable
        }
    }

    public override init(frame: CGRect) {
        super.init(frame: frame)
        initializeUI()
        addConstraints()
    }

    @available(*, unavailable)
    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    public func setupUI(with uiModel: UiModel) {
        button.setTitle(uiModel.title, for: .normal)
    }

    @IBAction private func didTapAction() {
        action?()
    }
}

extension CTAButtonView {
    private func initializeUI() {
        translatesAutoresizingMaskIntoConstraints = false
        backgroundColor = .clear

        button = .init(backgroundColor: tintColor)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.cornerRadius = 24
        button.titleLabel?.font = FontStyle.heading2.font
        button.isEnabled = true
        button.addTarget(self, action: #selector(didTapAction), for: .touchUpInside)
        button.setTitleColor(.white, for: .disabled)
        addSubview(button)

        horizontalLine = .init(frame: .zero)
        horizontalLine.backgroundColor = .lightGray
        horizontalLine.translatesAutoresizingMaskIntoConstraints = false
        horizontalLine.isHidden = true
        addSubview(horizontalLine)
    }

    private func addConstraints() {
        NSLayoutConstraint.activate([
            horizontalLine.topAnchor.constraint(equalTo: topAnchor),
            horizontalLine.leadingAnchor.constraint(equalTo: leadingAnchor),
            horizontalLine.trailingAnchor.constraint(equalTo: trailingAnchor),
            horizontalLine.heightAnchor.constraint(equalToConstant: 1),
        ])

        NSLayoutConstraint.activate([
            button.topAnchor.constraint(equalTo: horizontalLine.bottomAnchor, constant: 8),
            button.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            button.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            button.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -8),
            button.heightAnchor.constraint(equalToConstant: 48),
        ])
    }
}

public extension CTAButtonView {
    struct UiModel {
        let title: String
    }
}

class CTAButtonViewCard: CardItem<ViewWrapperCell<CTAButtonView>> {
    let title: String
    let action: (() -> Void)?

    init(title: String, action: (() -> Void)?) {
        self.title = title
        self.action = action
    }
    
    override func cellFor(_ collectionView: UICollectionView, indexPath: IndexPath) -> UICollectionViewCell {
        let cell: ViewWrapperCell<CTAButtonView> = collectionView.dequeueReusableCell(for: indexPath)
        cell.view.setupUI(with: .init(title: title))
        cell.view.action = action
        return cell
    }
}
