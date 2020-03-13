import Foundation

struct Asset: Codable, Identifiable, Hashable {
    var id: String = UUID().uuidString
    
    let amount: String
    let assetID: String
    let iconURL: String
    let symbol: String
    let type: String
    
    enum CodingKeys: String, CodingKey {
        case amount
        case assetID = "asset_id"
        case iconURL = "icon_url"
        case symbol, type
    }
    
    var amountValue: Double {
        return Double(amount) ?? 0.0
    }
}
