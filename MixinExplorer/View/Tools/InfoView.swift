import SwiftUI

struct InfoView: View {
    @EnvironmentObject var store: Store
    
    var body: some View {
        ScrollView {
            VStack(alignment: .center, spacing: 8) {
                Image("Mixin")
                .resizable()
                   .frame(width: 60, height: 60)
                   .aspectRatio(contentMode: .fit)
                    .padding(30)
                
                HStack {
                    Text("Website:")
                        .font(Font.system(size: 16))
                        .foregroundColor(Color(.secondaryLabel))
                        .lineLimit(1)
                    Button("https://mixin.one") {
                        UIApplication.shared.open(URL(string: "https://mixin.one")!,options: [:], completionHandler: nil)
                    }
                        .frame(maxWidth: .infinity, alignment: .trailing)
                        .font(Font.system(size: 16))
                }
                
                HStack {
                    Text("Assets Count:")
                        .font(Font.system(size: 16))
                        .foregroundColor(Color(.secondaryLabel))
                        .lineLimit(1)
                    Text("\(store.appState.mixinNetworkAssetList.assetsCount)").frame(maxWidth: .infinity, alignment: .trailing)
                        .font(Font.system(size: 16))
                        .foregroundColor(Color(.label))
                }
                HStack {
                    Text("Peak Throughput:")
                        .font(Font.system(size: 16))
                        .foregroundColor(Color(.secondaryLabel))
                        .lineLimit(1)
                    Text("\(store.appState.mixinNetworkAssetList.peakThroughput)").frame(maxWidth: .infinity, alignment: .trailing)
                        .font(Font.system(size: 16))
                        .foregroundColor(Color(.label))
                }
                HStack {
                    Text("Snapshots Count:")
                        .font(Font.system(size: 16))
                        .foregroundColor(Color(.secondaryLabel))
                        .lineLimit(1)
                    Text("\(store.appState.mixinNetworkAssetList.snapshotsCount)").frame(maxWidth: .infinity, alignment: .trailing)
                        .font(Font.system(size: 16))
                        .foregroundColor(Color(.label))
                }
                
                HStack {
                    Text("Chain Capitalization:")
                        .font(Font.system(size: 16))
                        .foregroundColor(Color(.secondaryLabel))
                        .lineLimit(1)
                    Text("\(store.appState.topAsset.capitalization.decimalFormatter) USD").frame(maxWidth: .infinity, alignment: .trailing)
                        .font(Font.system(size: 16))
                        .foregroundColor(Color(.label))
                }
                
                HStack {
                    Text("Node Count:")
                        .font(Font.system(size: 16))
                        .foregroundColor(Color(.secondaryLabel))
                        .lineLimit(1)
                    Text("\(store.appState.nodes.mixinnetwork?.nodes.count ?? 0) ").frame(maxWidth: .infinity, alignment: .trailing)
                        .font(Font.system(size: 16))
                        .foregroundColor(Color(.label))
                }
                
                Spacer()
            }
            .padding(EdgeInsets(top: 8, leading: 20, bottom: 0, trailing: 20))
            
        }.navigationBarTitle("Mixin Network")
    }
}

struct InfoView_Previews: PreviewProvider {
    static var previews: some View {
        InfoView()
    }
}
