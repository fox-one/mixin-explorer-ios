import SwiftUI

struct NodeDetailView: View {
    let node: MixinNode
    
    fileprivate func ItemList(title: LocalizedStringKey, value: String) -> some SwiftUI.View {
        Group {
            VStack(spacing: 8) {
                Text(title)
                    .font(Font.system(size: 15))
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .foregroundColor(Color(.secondaryLabel))
                    .lineLimit(1)
                Text(value)
                    .font(Font.system(size: 15))
                    .frame(maxWidth: .infinity,alignment: .leading)
                    .foregroundColor(Color(.label))
            }
            Divider()
        }
    }
    
    var body: some View {
        VStack(spacing: 8) {
            VStack(alignment: .leading) {
                if node.stat.data != nil {
                    if node.stat.data?.failed == nil {
                        ItemList(title: "Status:", value: "🟢")
                    } else {
                        ItemList(title: "Status:", value: "🔴")
                    }
                }
                
                ItemList(title:"Host:", value: node.host)
                ItemList(title:"Signer:", value: node.signer)
                
                
                if node.stat.data?.failed == nil {
                    ItemList(title:"Version:", value: node.stat.data!.version ?? "")
                    ItemList(title:"Topology:", value: "\(node.stat.data!.graph!.topology)")
                    ItemList(title: "Node:", value: node.stat.data!.node ?? "")
                    ItemList(title:"UP Time:", value: node.stat.data!.uptime ?? "")
                }
            }
            Spacer()
        }.navigationBarTitle(node.name)
            .padding(20)
    }
}
