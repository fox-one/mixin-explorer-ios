import SwiftUI

struct NodeListView: View {
    @EnvironmentObject var store: Store
    
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
                        Section {
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
        }.navigationBarTitle("Node Status")
    }
}

struct NodeListView_Previews: PreviewProvider {
    static var previews: some View {
        NodeListView()
    }
}
