import SwiftUI
import Kingfisher

struct SnapshotRowView: SwiftUI.View {
    let model: Snapshot
    var body: some SwiftUI.View {
        VStack(spacing: 10.0) {
            HStack {
                Text("Snapshot ID:")
                    .font(Font.system(size: 14))
                    .foregroundColor(Color(.secondaryLabel))
                .lineLimit(1)
                
                Button("\(model.snapshotID)") {
                    UIPasteboard.general.string = self.model.snapshotID
                    postNoti(subtitle: self.model.snapshotID)
                }
                    .multilineTextAlignment(.leading)
                    .lineLimit(1)
                    .frame(maxWidth: .infinity, alignment: .trailing)
                    .foregroundColor(Color(.label))
                    .font(Font.system(size: 14))
                    .minimumScaleFactor(0.9)
            }
            HStack {
                Text("Amount:")
                    .font(Font.system(size: 14))
                    .foregroundColor(Color(.secondaryLabel))
                .lineLimit(1)
                Text("\(model.amount) \(model.asset.symbol)").frame(maxWidth: .infinity, alignment: .trailing)
                    .font(Font.system(size: 14))
                    .foregroundColor(Color(.label))
            }
            HStack {
                Text("Time:")
                    .font(Font.system(size: 14))
                    .foregroundColor(Color(.secondaryLabel))
                .lineLimit(1)
                Text("\(model.date.timeString)").frame(maxWidth: .infinity, alignment: .trailing)
                    .font(Font.system(size: 14))
                    .foregroundColor(Color(.label))
            }
            Divider()
        }
        .padding(EdgeInsets(top: 4, leading: 0, bottom: 0, trailing: 0))
        
    }
}

//struct SnapshotRow_Previews: PreviewProvider {
//    static var previews: some SwiftUI.View {
//        
//        SnapshotRowView(model:
//            Snapshot(amount: "-0.00000001",
//                     asset:
//                Snapshot.SnapAsset(assetID: "c6d0c728-2624-429b-8e0d-d9d19b6592fa",
//                                   assetKey: "c6d0c728-2624-429b-8e0d-d9d19b6592fa",
//                                   chainID: "c6d0c728-2624-429b-8e0d-d9d19b6592fa",
//                                   iconURL: "https://mixin-images.zeromesh.net/HvYGJsV5TGeZ-X9Ek3FEQohQZ3fE9LBEBGcOcn4c4BNHovP4fW4YB97Dg5LcXoQ1hUjMEgjbl1DPlKg1TW7kK6XP=s128",
//                                   name: "Bitcoin",
//                                   symbol: "BTC",
//                                   type: "asset"),
//                     createdAt: "2020-02-08T13:52:13.154923Z",
//                     snapshotID: "b754eeab-0d9e-44a5-9c58-2763fa9aec9d",
//                     source: "TRANSFER_INITIALIZED",
//                     type: "snapshot"))
//    }
//}
