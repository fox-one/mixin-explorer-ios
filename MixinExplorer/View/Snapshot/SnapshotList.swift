import SwiftUI

struct SnapshotList: View {
    @EnvironmentObject var store: Store
    var settings: AppState.SelectedAssetSnapshotList {
        store.appState.selectAssetSnapShotList
    }
    
    var body: some View {
        ForEach(store.appState.selectAssetSnapShotList.snapshots) { snapshot in
            NavigationLink(destination: SnapshotDetailView(model: snapshot)) {
                SnapshotRowView(model: snapshot)
            }
        }
    }
}

struct SnapshotList_Previews: PreviewProvider {
    static var previews: some View {
        SnapshotList()
    }
}
