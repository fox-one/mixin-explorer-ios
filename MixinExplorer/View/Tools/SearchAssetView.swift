import Foundation
import SwiftUI


struct SearchAssetView: View {
    @EnvironmentObject var store: Store
    var settingsBinding: Binding<AppState.Settings> {
        $store.appState.settings
    }
    
    var settings: AppState.Settings {
        store.appState.settings
    }
    
    var snapshotsBinding: Binding<AppState.SearchAssetList> {
        $store.appState.searchAsset
    }
    
    var body: some View {
        Form {
            Section(header: Text("Search Asset Tip")) {
                TextField("Symbol", text: settingsBinding.checker.symbol)
                
                HStack {
                    Spacer()
                    Button("Search") {
                        self.store.dispatch(.searchAssets(symbol: self.settings.checker.symbol))
                    }
                    Spacer()
                }
            }
            
            Section(header: Text("Result")) {
                if store.appState.searchAsset.loading {
                    HStack {
                        Spacer()
                        ActivityIndicator(shouldAnimate: snapshotsBinding.loading)
                        Spacer()
                    }
                    
                } else {
                    if store.appState.searchAsset.asset.count != 0 {
                        ForEach(store.appState.searchAsset.asset) { asset in
                            NavigationLink(destination: AssetDetailView(model: asset)) {
                                AssetRowView(model: asset)
                            }
                        }
                    } else {
                        HStack {
                            Spacer()
                            EmptyView()
                            Spacer()
                        }
                    }
                }
            }
            
        }.navigationBarTitle("Search Asset")
    }
}
