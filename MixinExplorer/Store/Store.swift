import Foundation
import Combine
import CoreData
import UIKit

class Store: ObservableObject {
    @Published var appState = AppState()
    var disposeBag = DisposeBag()
    
    init() {
        setupObservers()
    }
    
    func setupObservers() {
    }
    
    static func reduce(state: AppState, action: AppAction) -> (AppState, AppCommand?) {
        var appState = state
        var appCommand: AppCommand?
        switch action {
        case .loadMixinAssets:
            if appState.mixinNetworkAssetList.loadingAssets {
                break
            }
            appState.mixinNetworkAssetList.loadingAssets = true
            appState.settings.resultLoading.requestLoading = true
            
            appCommand = LoadMixinAssetCommand()
        case .loadMixinAssetsDone(let result):
            switch result {
            case .success(let asstes):
                appState.mixinNetworkAssetList.assets = asstes.assets
                
                for asset in asstes.assets {
                    appState.mixinNetworkAssetList.assetMap[asset.assetID] = asset
                }
                
                for chain in asstes.chains {
                    appState.mixinNetworkAssetList.chainMap[chain.chainID] = chain
                }
                
                appState.mixinNetworkAssetList.chains = asstes.chains
                appState.mixinNetworkAssetList.assetsCount = asstes.assetsCount
                appState.mixinNetworkAssetList.peakThroughput = asstes.peakThroughput
                appState.mixinNetworkAssetList.snapshotsCount = asstes.snapshotsCount
                appState.mixinNetworkAssetList.loadingAssets = false
                appState.settings.resultLoading.requestLoading = false
            case .failure(let error):
                break
            }
            appState.settings.resultLoading.requestLoading = false
        case .toggleDisplay(let type):
            appState.settings.exploreType = type
        case .loadMixinAsset(let assetID):
            if appState.snapDetail.loadingAsset {
                break
            }
            
            appState.snapDetail.asset = nil
            appState.selectAssetSnapShotList.snapshots = []
            appState.snapDetail.chain = nil
//            appState.snapDetail.coin = nil
            
            appState.snapDetail.loadingAsset = true
            appCommand = LoadAssetDetailCommand(assetId: assetID)
            
        case .laodMixinAssetDone(let result):
            switch result {
            case .success(let asset):
                appState.snapDetail.asset = asset
                let filterChain = appState.mixinNetworkAssetList.chains.filter { $0.chainID == asset.chainID }
                appState.snapDetail.chain = filterChain.first
            case .failure(let error):
                break
            }
            appState.snapDetail.loadingAsset = false
        case .removeSelectedMixinAsset:
            appState.snapDetail.asset = nil
            appState.selectAssetSnapShotList.snapshots = []
            appState.snapDetail.chain = nil
//            appState.snapDetail.coin = nil
        case .loadSnapshots(let assetId):
            if appState.selectAssetSnapShotList.loadingSnapshots.loadingSnapShots {
                break
            }
            
            appState.selectAssetSnapShotList.loadingSnapshots.loadingSnapShots = true
            appCommand = LoadSnapshotsCommand(assetId: assetId)
            
        case .loadSnapshotsDone(let result):
            switch result {
            case .success(let snapshots):
                appState.selectAssetSnapShotList.snapshots = snapshots
            case .failure(let error):
                break
            }
            appState.selectAssetSnapShotList.loadingSnapshots.loadingSnapShots = false
        case .loadSnapshot(let snapshot):
            if appState.currentSnapShot.loadingSnapShot {
                break
            }
            
            appState.currentSnapShot.loadingSnapShot = true
            appCommand = LoadSnapshotCommand(snapshotID: snapshot)
        case .loadSnapshotDone(let result):
            switch result {
            case .success(let snapshot):
                appState.currentSnapShot.snapshot = snapshot
            case .failure(let error):
                break
            }
            appState.currentSnapShot.loadingSnapShot = false
        case .loadCoinMarket(let symbol):
            if appState.snapDetail.loadingCoinMarket {
                break
            }
            
            appState.snapDetail.loadingCoinMarket = true
            appCommand = LoadCoinMarkerCommand(symbol: symbol)
            
        case .loadCoinMarketDone(let symbol, let result):
            switch result {
            case .success(let dataclass):
                appState.coinMarket[symbol] = dataclass.data
                appState.snapDetail.coin = dataclass.data
            case .failure(let error):
                break
            }
            appState.snapDetail.loadingCoinMarket = false
        case .loadVerifyToken(let token):
            if appState.verifyAsset.loadingVerifyAsset {
                break
            }
            
            appState.verifyAsset.loadingVerifyAsset = true
            appCommand = LoadVerifyAssetCommand(toke: token)
            
        case .loadVerifyTokenDone(let result):
            switch result {
            case .success(let asset):
                appState.verifyAsset.asset = asset
            case .failure(let error):
                break
            }
            appState.verifyAsset.loadingVerifyAsset = false
        case .loadMixinNode:
            if appState.nodes.loading {
                break
            }
            
            appState.nodes.loading = true
            appCommand = LoadMixinNodesCommand()
        case .loadMixineNodeDone(let result):
            switch result {
            case .success(let asset):
                appState.nodes.mixinnetwork = asset
            case .failure(let error):
                break
            }
            appState.nodes.loading = false
        case .loadMixinTopAssets:
            if appState.topAsset.loading {
                break
            }
            appState.topAsset.loading = true
            
            appCommand = LoadMixinTopAssetCommand()
        case .loadMixinTopAssetsDone(let result):
            switch result {
            case .success(let asset):
                
                let filterAssset = asset.filter { $0.assetId != "f5ef6b5d-cc5a-3d90-b2c0-a2fd386e7a3c"}
                
                let capitalization = filterAssset.reduce(0) { $0 + $1.capitalization }
                
                appState.topAsset.asset = filterAssset
                appState.topAsset.capitalization = capitalization
                
            case .failure(let error):
                break
            }
            appState.topAsset.loading = false
        case .searchAssets(let symbol):
            if appState.searchAsset.loading {
                break
            }
            
            appState.searchAsset.loading = true
            appCommand = SearchAssetsCommand(symbol: symbol)
            
        case .searchAssetsDone(let result):
            switch result {
            case .success(let asset):
                appState.searchAsset.asset = asset
            case .failure(let error):
                break
            }
            appState.searchAsset.loading = false
        case .loadFiat:
            if appState.fiats.loading {
                break
            }
            
            appState.fiats.loading = true
            appCommand = LoadingFiatCommand()
            
        case .loadFiatDone(let result):
            switch result {
            case .success(let fiats):
                appState.fiats.fiat = fiats
                fiats.forEach { fiat in
                    appState.fiats.fiatHash[fiat.code] = fiat.rate
                }
            case .failure(let error):
                break
            }
            appState.fiats.loading = false
            
        }
        
        return (appState, appCommand)
    }
    
    func dispatch(_ action: AppAction) {
        #if DEBUG
//        print("[ACTION]:\(action)")
        #endif
        
        let result = Store.reduce(state: appState, action: action)
        appState = result.0
        
        if let command = result.1 {
            #if DEBUG
//            print("[COMMAND]:\(command)")
            #endif
            command.execute(in: self)
        }
    }
}

class DisposeBag {
    private var values: [AnyCancellable] = []
    func add(_ value: AnyCancellable) {
        values.append(value)
    }
}


extension AnyCancellable {
    func add(to bag: DisposeBag) {
        bag.add(self)
    }
}
