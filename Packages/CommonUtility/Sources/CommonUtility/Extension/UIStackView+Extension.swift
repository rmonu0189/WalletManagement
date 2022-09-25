import UIKit

public extension UIStackView {
    func removeAllArrangedSubviews() {
        subviews.forEach { (view) in
            view.removeFromSuperview()
        }
    }
}
