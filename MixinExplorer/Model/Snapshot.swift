import Foundation

struct Snapshot: Codable, Identifiable {
    var id: String = UUID().uuidString
    let snapshotID: String
    let amount: String
    let asset: SnapAsset
    let createdAt: String
    let source: String
    let type: String

    enum CodingKeys: String, CodingKey {
        case amount, asset
        case createdAt = "created_at"
        case snapshotID = "snapshot_id"
        case source, type
    }
    
    struct SnapAsset: Codable {
        let assetID: String
        let assetKey: String
        let chainID: String
        let iconURL: String
        let name: String
        let symbol: String
        let type: String

        enum CodingKeys: String, CodingKey {
            case assetID = "asset_id"
            case assetKey = "asset_key"
            case chainID = "chain_id"
            case iconURL = "icon_url"
            case name, symbol, type
        }
    }
    
    var date: Date {
        let formatter = ISO8601DateFormatter()
        return formatter.date(from: createdAt) ?? Date()
    }
}
