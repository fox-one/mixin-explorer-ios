import SwiftUI

struct NodeView: View {
    @EnvironmentObject var store: Store
    var body: some View {
        Form {
            Section (header: Text("Node Status")) {
                NavigationLink(destination: NodeListView()) {
                    VStack(alignment: .leading, spacing: 10) {
                        HItemList(title: "Node Count:", value: " \(store.appState.nodes.mixinnetwork?.validateCount ?? 0)")
                        HItemList(title: "Fail Node:", value: "\(store.appState.nodes.mixinnetwork?.faileCount ?? 0)")
                        HItemList(title: "Update Time:", value: "\(store.appState.nodes.mixinnetwork?.date?.timeString ?? "")")
                    }.padding(EdgeInsets(top: 10, leading: 0, bottom: 10, trailing: 0))
                    
                }
            }
            
            Section (header: Text("Mining Tool")) {
                NavigationLink(destination: MiningCalculatorView()) {
                    Text("Mining")
                }
            }
        }
    }
}

struct NodeView_Previews: PreviewProvider {
    static var previews: some View {
        NodeView()
    }
}
