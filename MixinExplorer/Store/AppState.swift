import Foundation
import Combine

struct AppState {
    var settings = Settings()
    var mixinNetworkAssetList = MixinNetworkAssetList()
    var snapDetail = CurrentDetail()
    var selectAssetSnapShotList = SelectedAssetSnapshotList()
    var currentSnapShot = CurrentSnapShot()
    var coinMarket: [String : CoinMarketCoin] = [:]
    var verifyAsset = CurrentVerifyAsset()
    var nodes = MixinNodeList()
    var topAsset = TopAssetList()
    var searchAsset = SearchAssetList()
    var fiats = Fiats()
    

    @BundleJSONStorage(forResource: "Dapp", type: "json")
    var dapp: Dapps?
    
}

extension AppState {
    class TopAssetList {
        var asset: [TopAsset] = []
        var capitalization: Double = 0.0
          @Published var loading = false
      }
    
    struct MixinNetworkAssetList {
        var assets: [Asset] = []
        var assetMap: [String: Asset] = [:]
        var chainMap: [String :Chain] = [:]
        var chains: [Chain] = []
        var assetsCount: String = "0"
        var peakThroughput: String = "0"
        var snapshotsCount: String = "0"
        var loadingAssets = false
    }
    
    class Fiats {
        @Published var loading = false
        var fiat: [Fiat] = []
        var fiatHash:[String :Double] = [:]
    }
    
    class MixinNodeList {
        @BundleJSONStorage(forResource: "nodes", type: "json")
        var mixinnetwork: MinxinNetwork?
        @Published var loading = false
    }
    
    class CurrentVerifyAsset {
        var asset: [VerifyAsset] = []
        @Published var loadingVerifyAsset = false
    }
    
    class CurrentDetail {
        var asset: AssetDetail? = nil
        var chain: Chain? = nil
        var coin: CoinMarketCoin? = nil
        @Published var loadingAsset = false
        @Published var loadingCoinMarket = false
    }
    
    struct SelectedAssetSnapshotList {
        var snapshots: [Snapshot] = []
        var loadingSnapshots = LoadingSnapshots()
        
        class LoadingSnapshots {
            @Published var loadingSnapShots = false
        }
    }
    
    class CurrentSnapShot {
        var snapshot: Snapshot? = nil
         @Published var loadingSnapShot = false
    }
    
    class SearchAssetList {
        var asset: [TopAsset] = []
        @Published var loading = false
    }
    
    struct Settings {
        var exploreType: ExplorerType = .topAsset
        class SnapshotDetail {
            @Published var showSnapshot: Bool = false
        }
        
        var showSnapshot = SnapshotDetail()
        
        class ResulteLoading {
            @Published var requestLoading = false
        }
        
        var resultLoading = ResulteLoading()
        
        class InputChecker {
            @Published var snapshotID = ""
            @Published var token = ""
            @Published var symbol = ""
        }
        
        var checker = InputChecker()
    }
}

