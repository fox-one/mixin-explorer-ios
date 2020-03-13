import Foundation

struct Chain: Codable, Identifiable {
    var id: String = UUID().uuidString
    let chainID: String
    let depositBlockHeight: Int
    let externalBlockHeight: Int
    let iconURL: String
    let isSynchronized: Bool
    let managedBlockHeight: Int
    let name: String
    let type: String
    let withdrawalFee: String
    let withdrawalPendingCount: Int
    let withdrawalTimestamp: String
    
    enum CodingKeys: String, CodingKey {
        case chainID = "chain_id"
        case depositBlockHeight = "deposit_block_height"
        case externalBlockHeight = "external_block_height"
        case iconURL = "icon_url"
        case isSynchronized = "is_synchronized"
        case managedBlockHeight = "managed_block_height"
        case name, type
        case withdrawalFee = "withdrawal_fee"
        case withdrawalPendingCount = "withdrawal_pending_count"
        case withdrawalTimestamp = "withdrawal_timestamp"
    }
    
    var synchronized: String {
        return isSynchronized ? "YES" : "NO"
    }
    
    
    var date: Date {
        let formatter = ISO8601DateFormatter()
        return formatter.date(from: withdrawalTimestamp) ?? Date()
    }
}
