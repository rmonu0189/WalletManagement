import UIKit

extension UILabel {
    convenience init(style: FontStyle, color: UIColor? = nil) {
        self.init(frame: .zero)
        font = style.font
        if let color = color {
            textColor = color
        }
    }
}
