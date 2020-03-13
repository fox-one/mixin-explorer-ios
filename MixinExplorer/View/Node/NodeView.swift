import SwiftUI

struct NodeView: View {
    var body: some View {
        Form {
            Section (header: Text("Mining Tool")) {
                NavigationLink(destination: MiningCalculatorView()) {
                    Text("Mining")
                }
            }
            
            Section (header: Text("Node")) {
                NavigationLink(destination: NodeListView()) {
                    Text("Node Status")
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
