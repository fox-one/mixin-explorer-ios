import SwiftUI

struct ChainListView: View {
    @EnvironmentObject var store: Store
    
    var settingsBinding: Binding<AppState.Settings> {
        $store.appState.settings
    }
    
    var body: some View {
        Group {
            if store.appState.mixinNetworkAssetList.chains.isEmpty {
                ActivityIndicator(shouldAnimate: settingsBinding.resultLoading.requestLoading)
            } else {
                List {
                    ForEach(store.appState.mixinNetworkAssetList.chains) { chain in
                        NavigationLink(destination: MixinChainDetail(model: chain)) {
                            MixinChainRow(model: chain)
                        }
                    }
                }
            }
        }
        .navigationBarTitle("Chain")
    }
}

