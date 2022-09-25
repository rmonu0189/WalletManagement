import Foundation

public extension String {
    func last(upto: Int) -> String {
        if count >= upto {
            return String(suffix(upto))
        }
        return self
    }
}
