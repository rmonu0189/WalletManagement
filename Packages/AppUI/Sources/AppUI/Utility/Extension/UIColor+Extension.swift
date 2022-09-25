import UIKit

extension UIColor {
    static var background: UIColor { colorWithName("background") }
    static var equalBalance: UIColor { colorWithName("equalBalance") }
    static var negetiveBalance: UIColor { colorWithName("negetiveBalance") }
    static var positiveBalance: UIColor { colorWithName("positiveBalance") }
    static var lightBackground: UIColor { colorWithName("lightBackground") }
    static var cardBackground: UIColor { colorWithName("cardBackground") }
    static var insuranceAmount: UIColor { colorWithName("insuranceAmount") }
}

extension UIColor {
    private static func colorWithName(_ name: String) -> UIColor {
        UIColor(named: name, in: .main, compatibleWith: nil) ?? .black
    }
}
