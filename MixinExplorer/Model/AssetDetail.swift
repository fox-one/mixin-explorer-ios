import Foundation

struct AssetDetail: Codable {
    let amount: String
    let assetID: String
    let chainID: String
    let iconURL: String
    let name: String
    let snapshotsCount: Int
    let symbol: String
    let type: String
    
    enum CodingKeys: String, CodingKey {
        case amount
        case assetID = "asset_id"
        case chainID = "chain_id"
        case iconURL = "icon_url"
        case name
        case snapshotsCount = "snapshots_count"
        case symbol, type
    }
    
    var amountValue: Double {
         return Double(amount) ?? 0.0
     }
}
