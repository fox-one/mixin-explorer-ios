import SwiftUI
import Kingfisher

struct SnapshotDetailView: SwiftUI.View {
    let model: Snapshot
    var body: some SwiftUI.View {
        ScrollView {
            VStack(spacing: 5) {
                HStack(alignment: .top) {
                    KFImage(URL(string: model.asset.iconURL))
                        .placeholder{
                            SwiftUI.Image("placeholder")
                                .resizable()
                                .frame(width: 45, height: 45)
                                .aspectRatio(contentMode: .fit)
                    }
                    .resizable()
                    .frame(width: 45, height: 45)
                    .cornerRadius(15)
                    .aspectRatio(contentMode: .fit)
                    
                    Text("\(model.asset.name)").frame(maxWidth: .infinity, alignment: .leading)
                        .font(Font.system(size: 15))
                        .foregroundColor(Color(.label))
                        .padding(8)
                }
                
                VStack(spacing: 12) {
                    VStack(spacing: 8) {
                        Text("Snapshot ID:")
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .font(Font.system(size: 14))
                            .foregroundColor(Color(.secondaryLabel))
                        
                        Button("\(model.snapshotID)") {
                                       UIPasteboard.general.string = self.model.snapshotID
                                       postNoti(subtitle: self.model.snapshotID)
                                   }
                            .multilineTextAlignment(.leading)
                            .lineLimit(1)
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .foregroundColor(Color(.label))
                            .font(Font.system(size: 14))
                    }
                    
                    Divider()
                    
                    VStack(spacing: 8) {
                        Text("Amount:")
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .font(Font.system(size: 14))
                            .foregroundColor(Color(.secondaryLabel))
                        Text("\(model.amount) \(model.asset.symbol)").frame(maxWidth: .infinity, alignment: .leading)
                            .font(Font.system(size: 14))
                            .foregroundColor(Color(.label))
                    }
                    
                    Divider()
                    
                    VStack(spacing: 8) {
                        Text("Source:")
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .font(Font.system(size: 14))
                            .foregroundColor(Color(.secondaryLabel))
                        Text("\(model.source)").frame(maxWidth: .infinity, alignment: .leading)
                            .font(Font.system(size: 14))
                            .foregroundColor(Color(.label))
                    }
                    
                    Divider()
                    
                    VStack(spacing: 8) {
                        Text("Time:")
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .font(Font.system(size: 14))
                            .foregroundColor(Color(.secondaryLabel))
                        Text(" \(model.date.timeString)").frame(maxWidth: .infinity, alignment: .leading)
                            .font(Font.system(size: 14))
                            .foregroundColor(Color(.label))
                    }
                    
                    Spacer()
                }
            }
        }.padding(16)
            .navigationBarTitle("Snapshot Detail", displayMode: .inline)
    }
}

struct SnapshotRow_Previews: PreviewProvider {
    static var previews: some SwiftUI.View {
        SnapshotDetailView(model:
            Snapshot(snapshotID: "b754eeab-0d9e-44a5-9c58-2763fa9aec9d", amount: "-0.00000001",
                     asset:
                Snapshot.SnapAsset(assetID: "c6d0c728-2624-429b-8e0d-d9d19b6592fa",
                                   assetKey: "c6d0c728-2624-429b-8e0d-d9d19b6592fa",
                                   chainID: "c6d0c728-2624-429b-8e0d-d9d19b6592fa",
                                   iconURL: "https://mixin-images.zeromesh.net/HvYGJsV5TGeZ-X9Ek3FEQohQZ3fE9LBEBGcOcn4c4BNHovP4fW4YB97Dg5LcXoQ1hUjMEgjbl1DPlKg1TW7kK6XP=s148",
                                   name: "Bitcoin",
                                   symbol: "BTC",
                                   type: "asset"),
                     createdAt: "2020-02-08T13:52:13.154923Z",
                     source: "TRANSFER_INITIALIZED",
                     type: "snapshot"))
    }
}


