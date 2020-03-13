import SwiftUI

struct VerifyAssetView: View {
    @EnvironmentObject var store: Store
    var settingsBinding: Binding<AppState.Settings> {
        $store.appState.settings
    }
    
    var settings: AppState.Settings {
        store.appState.settings
    }
    
    var snapshotsBinding: Binding<AppState.CurrentVerifyAsset> {
        $store.appState.verifyAsset
    }
    
    var body: some View {
        Form {
            Section(header: Text("Verify Tip")) {
                TextField("Token", text: settingsBinding.checker.token)
                
                HStack {
                    Spacer()
                    Button("Search") {
                        self.store.dispatch(.loadVerifyToken(token: self.settings.checker.token))
                        print("Token")
                    }
                    Spacer()
                }
            }
            
            Section(header: Text("Result")) {
                if store.appState.verifyAsset.loadingVerifyAsset {
                    HStack {
                        Spacer()
                        ActivityIndicator(shouldAnimate: snapshotsBinding.loadingVerifyAsset)
                        Spacer()
                    }
                    
                } else {
                    if store.appState.verifyAsset.asset.count != 0 {
                        ForEach(store.appState.verifyAsset.asset) { asset in
                            VerifyAssetRowView(model: asset)
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
            
        }.navigationBarTitle("Token Verify")
    }
}
