import UIKit

enum FontStyle {
    case heading1
    case heading2
    case heading3
    case title
    case subtitle

    var font: UIFont {
        UIFont(name: fontName, size: size) ?? .systemFont(ofSize: size)
    }

    public var fontName: String {
        switch self {
        case .heading1, .heading2, .heading3:
            return "HelveticaNeue-Bold"
        case .title:
            return "HelveticaNeue"
        case .subtitle:
            return "HelveticaNeue"
        }
    }

    private var size: CGFloat {
        switch self {
        case .heading1: return 20
        case .heading3: return 15
        case .title, .heading2: return 17
        case .subtitle: return 13
        }
    }
}

extension UIFont {
    static func withStyle(_ style: FontStyle) -> UIFont {
        style.font
    }
}
