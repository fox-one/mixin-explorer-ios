import SwiftUI

struct AssetsListView: View {
    @EnvironmentObject var store: Store
    var topAsset: AppState.TopAssetList {
        store.appState.topAsset
    }
    
    var settingsBinding: Binding<AppState.TopAssetList> {
        $store.appState.topAsset
    }
    
    @State
    var title: String = ""
    
    var body: some View {
        Group {
            if topAsset.loading {
                ActivityIndicator(shouldAnimate: settingsBinding.loading)
            } else {
                VStack {
                    List {
                        Section {
                            ForEach(topAsset.asset) { asset in
                                NavigationLink(destination: AssetDetailView(model: asset)) {
                                    AssetRowView(model: asset)
                                }
                            }
                        }
                    }
                }
            }
        }
    }
    
}

struct AssetsListView_Preview: PreviewProvider {
    static var previews: some SwiftUI.View {
        let store = Store()
        let assets = [Asset(amount: "100.0", assetID: "BTC", iconURL: "", symbol: "BTC", type: "abc"),
                      Asset(amount: "100.0", assetID: "ETH", iconURL: "", symbol: "ETH", type: "abc")]
        
        store.appState.mixinNetworkAssetList.assets = assets
        return Group {
            AssetsListView().environmentObject(store)
        }
    }
}
