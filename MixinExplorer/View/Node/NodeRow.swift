import SwiftUI

struct NodeRow: View {
    let node: MixinNode
    var body: some View {
        HStack(spacing: 8) {
            VStack(alignment: .leading, spacing: 8) {
                HStack {
                    Text(node.name)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .foregroundColor(Color(.label))
                        .font(Font.system(size: 16, weight: .bold))
                        .padding(.bottom, 4)
                    
                    if node.stat.data != nil {
                        if node.stat.data?.failed == nil {
                            Text("Status: 🟢")
                                .frame(maxWidth: .infinity, alignment: .trailing)
                                .foregroundColor(Color(.secondaryLabel))
                                .font(Font.system(size: 15, weight: .bold))
                                .padding(.bottom, 4)
                        } else {
                            Text("Status: 🔴")
                                .frame(maxWidth: .infinity, alignment: .trailing)
                                .foregroundColor(Color(.secondaryLabel))
                                .font(Font.system(size: 15, weight: .bold))
                                .padding(.bottom, 4)
                        }
                    }
                }
                
                HStack {
                    Text("Host:")
                        .font(Font.system(size: 16))
                        .foregroundColor(Color(.secondaryLabel))
                        .lineLimit(1)
                    Text(node.host)
                        .frame(maxWidth: .infinity, alignment: .trailing)
                        .foregroundColor(Color(.label))
                        .font(Font.system(size: 16, weight: .light))
                        .padding(.bottom, 4)
                }
                
                if node.stat.data != nil {
                    HStack {
                        HStack {
                            Text("UP Time:")
                                .font(Font.system(size: 16))
                                .foregroundColor(Color(.secondaryLabel))
                                .lineLimit(1)
                            Text(node.stat.data!.uptime ?? "")
                                .frame(maxWidth: .infinity, alignment: .trailing)
                                .foregroundColor(Color(.label))
                                .font(Font.system(size: 16, weight: .light))
                                .padding(.bottom, 4)
                        }
                    }
                    
                }
            }
        }
    }
}


