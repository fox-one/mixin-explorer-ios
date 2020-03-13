import Foundation

struct NetworkList<T: Codable>: Codable {
    let data: T
}

struct MixinNetworkAsset: Codable {
    let assets: [Asset]
    let assetsCount: String
    let chains: [Chain]
    let peakThroughput, snapshotsCount, type: String
    
    enum CodingKeys: String, CodingKey {
        case assets
        case assetsCount = "assets_count"
        case chains
        case peakThroughput = "peak_throughput"
        case snapshotsCount = "snapshots_count"
        case type
    }
}

struct VerifyAsset: Codable, Identifiable {
    var id: String = UUID().uuidString
    let type: String
    let assetID: String
    let chainID: String
    let symbol: String
    let name: String
    let iconURL: String
    let balance: String
    let destination: String
    let tag: String
    let priceBtc: String
    let priceUsd: String
    let changeBtc: String
    let changeUsd: String
    let assetKey: String
    let mixinID: String
    let confirmations: Int
    let capitalization: Int

    enum CodingKeys: String, CodingKey {
        case type = "type"
        case assetID = "asset_id"
        case chainID = "chain_id"
        case symbol = "symbol"
        case name = "name"
        case iconURL = "icon_url"
        case balance = "balance"
        case destination = "destination"
        case tag = "tag"
        case priceBtc = "price_btc"
        case priceUsd = "price_usd"
        case changeBtc = "change_btc"
        case changeUsd = "change_usd"
        case assetKey = "asset_key"
        case mixinID = "mixin_id"
        case confirmations = "confirmations"
        case capitalization = "capitalization"
    }
}
