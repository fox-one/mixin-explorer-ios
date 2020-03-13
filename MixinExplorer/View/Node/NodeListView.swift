import SwiftUI

struct NodeListView: View {
    @EnvironmentObject var store: Store
    
    var settings: AppState.Settings {
        store.appState.settings
    }
    
    var snapshotsBinding: Binding<AppState.MixinNodeList> {
        $store.appState.nodes
    }
    
    
    var body: some View {
        Group {
            if store.appState.nodes.mixinnetwork == nil {
                HStack {
                    Spacer()
                    ActivityIndicator(shouldAnimate: snapshotsBinding.loading)
                    Spacer()
                }
            } else {
                if store.appState.nodes.mixinnetwork != nil {
                    List {
                        Section(header: self.header() ) {
                            ForEach(store.appState.nodes.mixinnetwork?.nodes ?? []) { node in
                                NavigationLink(destination: NodeDetailView(node: node)) {
                                    NodeRow(node: node)
                                }
                            }
                        }
                        
                    }
                } else {
                    VStack(alignment: .center) {
                        EmptyView()
                    }
                }
            }
        }.navigationBarTitle("Node")
    }
    
    func header() -> some View {
        let text = "Node Count:" + " \(store.appState.nodes.mixinnetwork?.validateCount ?? 0)" + "  Fail Node:\(store.appState.nodes.mixinnetwork?.faileCount ?? 0)"
        
        return Text(text)
            .font(.headline)
    }
    
}

struct NodeListView_Previews: PreviewProvider {
    static var previews: some View {
        NodeListView()
    }
}
