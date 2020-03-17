import Foundation

struct Fiat: Codable, Identifiable {
    var id: String { return "\(self)" }
    let code: String
    let rate: Double

    enum CodingKeys: String, CodingKey {
        case code
        case rate
    }
}
