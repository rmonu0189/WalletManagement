import Foundation

public extension Encodable {
    func toJSON() -> [String: Any] {
        do {
            let encoder = JSONEncoder()
            let jsonData = try encoder.encode(self)
            let json = try JSONSerialization.jsonObject(with: jsonData, options: JSONSerialization.ReadingOptions.allowFragments)
            return json as? [String: Any] ?? [:]
        } catch {
            return [:]
        }
    }

    func toString() -> String {
        do {
            let encoder = JSONEncoder()
            let jsonData = try encoder.encode(self)
            return String(data: jsonData, encoding: .utf8) ?? ""
        } catch {
            return ""
        }
    }
}
