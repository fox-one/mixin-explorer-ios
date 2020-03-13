import Foundation

public class DateFormatManager {
    public static let shared = DateFormatManager()
    let formatter = DateFormatter()

    init() {
        formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
    }

    public func formatter(_ date: Date) -> String {
        return formatter.string(from: date)
    }

    public func formatterTimeInterval(_ timeInterval: Double, format: String) -> String {
        formatter.dateFormat = format
        let realTimeInterval = TimeInterval(timeInterval / 1000)
        let date = Date(timeIntervalSince1970: Double(realTimeInterval))
        return formatter.string(from: date)
    }
}
