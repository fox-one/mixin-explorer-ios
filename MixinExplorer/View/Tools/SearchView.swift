import SwiftUI

struct SearchView: View {
    @EnvironmentObject var store: Store
    var settingsBinding: Binding<AppState.Settings> {
        $store.appState.settings
    }
    
    var settings: AppState.Settings {
        store.appState.settings
    }
    
    var snapshotsBinding: Binding<AppState.CurrentSnapShot> {
        $store.appState.currentSnapShot
    }
    
    var body: some View {
        Form {
            Section(header: Text("Search")) {
                TextField("Snapshot ID", text: settingsBinding.checker.snapshotID)
                HStack {
                    Spacer()
                    Button("Search") {
                        self.store.dispatch(.loadSnapshot(snopshotID: self.settings.checker.snapshotID))
                        //                        "Search")
                    }
                    Spacer()
                }
                
            }
            
            Section(header: Text("Result")) {
                if store.appState.currentSnapShot.loadingSnapShot {
                    ActivityIndicator(shouldAnimate: snapshotsBinding.loadingSnapShot)
                } else {
                    if store.appState.currentSnapShot.snapshot != nil {
                        NavigationLink(destination: SnapshotDetailView(model: store.appState.currentSnapShot.snapshot!)) {
                            SnapshotRowView(model: store.appState.currentSnapShot.snapshot!)
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
        }.navigationBarTitle("Search Snapshot")
    }
}
