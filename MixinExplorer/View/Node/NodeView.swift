import SwiftUI

struct NodeView: View {
    @EnvironmentObject var store: Store
    var usd: QuoteUSD? {
        store.appState.snapDetail.coin?.coin.quote.usd
    }
    
    
    var body: some View {
        Form {
            if store.appState.snapDetail.coin?.coin.quote.usd != nil {
                Section {
                    VStack(alignment: .leading, spacing: 10) {
                        
                        HStack(alignment: .firstTextBaseline) {
                            Text("XIN").font(.system(size: 21, weight: .bold))
                            Spacer()
                        }
                        
                        HStack(alignment: .firstTextBaseline) {
                            Text("$\(self.usd!.price.decimalFormatter)").font(Font.custom("DINAlternate-Bold", size: 22))
                            Text("USD").font(.system(size: 15, weight: .bold))
                            Text(String(format: "%.2f%%", self.usd!.percentChange24H)).font(Font.custom("DINAlternate-Bold", size: 15))
                                .foregroundColor( self.usd!.percentChange24H > 0 ? .red: .green)
                                                  Spacer()
                            }
                        ValueItemList(title: "Volume (24h):", value: "\(self.usd!.volume24H.decimalFormatter)")
                        ValueItemList(title: "Market Cap:", value: "\(self.usd!.marketCap.decimalFormatter)")
                        
                        
                    }
                    .padding(EdgeInsets(top: 10, leading: 0, bottom: 10, trailing: 0))
                    
                }
            }
            
            Section (header: Text("Node Status")) {
                NavigationLink(destination: NodeListView()) {
                    VStack(alignment: .leading, spacing: 10) {
                        HItemList(title: "Node Count:", value: " \(store.appState.nodes.mixinnetwork?.validateCount ?? 0)")
                        HItemList(title: "Fail Node:", value: "\(store.appState.nodes.mixinnetwork?.faileCount ?? 0)")
                        HItemList(title: "Update Time:", value: "\(store.appState.nodes.mixinnetwork?.date?.timeString ?? "")")
                    }
                    .padding(EdgeInsets(top: 10, leading: 0, bottom: 10, trailing: 0))
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
