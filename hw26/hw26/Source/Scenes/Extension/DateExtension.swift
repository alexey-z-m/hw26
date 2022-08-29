import Foundation

extension Date {
    /// Convert date to string. Format: "dd.MM.yyyy"
    func convetrToString() -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd.MM.yyyy"
        return formatter.string(from: self)
    }
}
extension String {
    /// Convert string to date. Format: "dd.MM.yyyy"
    func convertToDate() -> Date? {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd.MM.yyyy"
        return formatter.date(from: self)
    }
}
