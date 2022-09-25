public class AppLogger {
    public enum Level: Int8 {
        case info
        case warning
        case error
    }

    public var enable: Bool = true
    public var logLevel: Level = .info

    private static var shared = AppLogger()
    private init() {}

    fileprivate func log(_ message: Any..., level: Level = .error) {
        guard enable else { return }
        guard logLevel.rawValue <= level.rawValue else { return }
        for messageItem in message {
            if let item = messageItem as? [Any] {
                for value in item {
                    print(value, separator: " ", terminator: "")
                }
            } else {
                print(messageItem)
            }
        }
        print("", terminator: "\n")
    }
}

public extension AppLogger {
    static func setEnable(_ enable: Bool, level: Level = .info) {
        AppLogger.shared.enable = enable
        AppLogger.shared.logLevel = level
    }

    static func log(_ message: Any..., level: Level = .info) {
        AppLogger.shared.log(message, level: level)
    }
}
