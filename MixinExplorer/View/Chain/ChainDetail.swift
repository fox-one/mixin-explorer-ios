import SwiftUI
import Kingfisher

struct MixinChainDetail: SwiftUI.View {
    let model: Chain
    
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
    
    var body: some SwiftUI.View {
        VStack(spacing: 10) {
            VStack(spacing: 0) {
                KFImage(URL(string: model.iconURL))
                    .placeholder{
                        SwiftUI.Image("placeholder")
                            .resizable()
                            .frame(width: 60, height: 60)
                }
                .resizable()
                .frame(width: 60, height: 60)
                .cornerRadius(30)
                .aspectRatio(contentMode: .fit)
                HStack {
                    Text(model.name)
                        .frame(maxWidth: .infinity,alignment: .center)
                        .foregroundColor(Color(.label))
                        .font(Font.system(size: 20, weight: .bold))
                }
            }
            
            VStack(alignment: .leading, spacing: 8) {
                ItemList(title: "Withdrawal Pending Count:", value: "\(model.withdrawalPendingCount)")
                ItemList(title: "Withdrawal Fee:", value: "\(model.withdrawalFee)")
                ItemList(title: "Synchronized:", value: "\(model.synchronized)")
                ItemList(title: "Deposit Block Height:", value: "\(model.depositBlockHeight)")
                ItemList(title: "External Block Height:", value: "\(model.externalBlockHeight)")
                ItemList(title: "Managed Block Height:", value: "\(model.managedBlockHeight)")
                ItemList(title: "Withdrawal Timestamp:", value: "\(model.date.timeString)")
            }
            
            Spacer()
        }
            
            
        .padding(20)
        .navigationBarTitle("", displayMode: .inline)
    }
}

struct MixinChainDetail_Previews: PreviewProvider {
    static var previews: some SwiftUI.View {
        let chain = Chain(chainID: "770a1e5-6086-44d5-b60f-545f9d9e8ffd",
                          depositBlockHeight: 3155075,
                          externalBlockHeight: 3155194,
                          iconURL: "aa",
                          isSynchronized: true,
                          managedBlockHeight: 15233,
                          name: "BTC",
                          type: "chain",
                          withdrawalFee: "0.01",
                          withdrawalPendingCount: 0,
                          withdrawalTimestamp: "2020-02-14T14:49:14.575959432Z")
        return Group { MixinChainDetail(model: chain) }
    }
}

