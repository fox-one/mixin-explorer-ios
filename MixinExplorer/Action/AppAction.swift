import Foundation

enum AppAction {
    case toggleDisplay(type: ExplorerType)
    
    case loadMixinAssets
    case loadMixinAssetsDone(result: Result<MixinNetworkAsset, AppError>)
    
    case loadMixinTopAssets
    case loadMixinTopAssetsDone(result: Result<[TopAsset], AppError>)
    
    case loadMixinAsset(assetID: String)
    case laodMixinAssetDone(result: Result<AssetDetail, AppError>)
    
    case removeSelectedMixinAsset
    
    case loadSnapshots(assetId: String)
    case loadSnapshotsDone(result: Result<[Snapshot], AppError>)
    
    case loadSnapshot(snopshotID: String)
    case loadSnapshotDone(result: Result<Snapshot, AppError>)
    
    case loadCoinMarket(symbol: String)
    case loadCoinMarketDone(symbol: String, result: Result<CoinMarketResponse, AppError>)
    
    case loadVerifyToken(token: String)
    case loadVerifyTokenDone(result: Result<[VerifyAsset], AppError>)
    
    case loadMixinNode
    case loadMixineNodeDone(result: Result<MinxinNetwork, AppError>)
    
    case searchAssets(symbol: String)
    case searchAssetsDone(result: Result<[TopAsset], AppError>)
    
    case loadFiat
    case loadFiatDone(result: Result<[Fiat], AppError>)
}
