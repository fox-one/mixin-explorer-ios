import SwiftUI
import Kingfisher

struct MixinChainRow: SwiftUI.View {
    let model: Chain
    var body: some SwiftUI.View {
        VStack {
            HStack(spacing: 8) {
                KFImage(URL(string: model.iconURL))
                    .placeholder{
                        SwiftUI.Image("placeholder")
                            .resizable()
                            .frame(width: 35.0, height: 35.0)
                }
                .resizable()
                .frame(width: 35.0, height: 35.0)
                .cornerRadius(15)
                .aspectRatio(contentMode: .fit)
                HStack {
                    Text(model.name)
                        .frame(maxWidth: .infinity,alignment: .leading)
                        .foregroundColor(Color(.label))
                        .font(Font.system(size: 16, weight: .bold))
                }
            }
            VStack(alignment: .leading, spacing: 2) {
                HStack {
                    Text("Withdrawal Fee:")
                        .font(Font.system(size: 14))
                        .foregroundColor(Color(.secondaryLabel))
                        .lineLimit(1)
                    Text("\(model.withdrawalFee)")
                        .font(Font.system(size: 14))
                        .frame(maxWidth: .infinity,alignment: .trailing)
                        .foregroundColor(Color(.label))
                }
                
                HStack {
                    Text("Synchronized:")
                        .font(Font.system(size: 14))
                        .foregroundColor(Color(.secondaryLabel))
                        .lineLimit(1)
                    Text("\(model.synchronized)")
                        .font(Font.system(size: 14))
                        .frame(maxWidth: .infinity,alignment: .trailing)
                        .foregroundColor(Color(.label))
                        .lineLimit(1)
                }
                
            }
        }.padding(4)
    }
    
}

extension Date {
    var timeString: String {
        return DateFormatManager.shared.formatter(self)
    }
}

struct ChainRow_Previews: PreviewProvider {
    static var previews: some SwiftUI.View {
        let chain = Chain(chainID: "770a1e5-6086-44d5-b60f-545f9d9e8ffd",
                          depositBlockHeight: 3145075,
                          externalBlockHeight: 3145194,
                          iconURL: "aa",
                          isSynchronized: true,
                          managedBlockHeight: 14233,
                          name: "BTC",
                          type: "chain",
                          withdrawalFee: "0.01",
                          withdrawalPendingCount: 0,
                          withdrawalTimestamp: "2020-02-14T14:49:14.575959432Z")
        return Group { MixinChainRow(model: chain) }
    }
}
