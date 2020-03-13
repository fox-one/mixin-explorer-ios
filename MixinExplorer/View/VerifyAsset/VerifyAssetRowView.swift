import SwiftUI

struct VerifyAssetRowView: View {
    let model: VerifyAsset
    var body: some SwiftUI.View {
        VStack(spacing: 10.0) {
            HStack {
                Text("Name:")
                    .font(Font.system(size: 14))
                    .foregroundColor(Color(.secondaryLabel))
                    .lineLimit(1)
                
                Text("\(model.name)")
                    .multilineTextAlignment(.leading)
                    .lineLimit(1)
                    .frame(maxWidth: .infinity, alignment: .trailing)
                    .foregroundColor(Color(.label))
                    .font(Font.system(size: 14))
            }
            
            HStack {
                Text("Symbol:")
                    .font(Font.system(size: 14))
                    .foregroundColor(Color(.secondaryLabel))
                    .lineLimit(1)
                Text("\(model.symbol)").frame(maxWidth: .infinity, alignment: .trailing)
                    .font(Font.system(size: 14))
                    .foregroundColor(Color(.label))
            }
            
            HStack {
                Text("Balance:")
                    .font(Font.system(size: 14))
                    .foregroundColor(Color(.secondaryLabel))
                    .lineLimit(1)
                Text("\(model.balance) \(model.symbol)" ).frame(maxWidth: .infinity, alignment: .trailing)
                    .font(Font.system(size: 14))
                    .foregroundColor(Color(.label))
            }
        }
        .padding(EdgeInsets(top: 4, leading: 0, bottom: 0, trailing: 0))
        
    }
}

struct VerifyAssetRowView_Previews: PreviewProvider {
    static var previews: some View {
        VerifyAssetRowView(model: VerifyAsset(type: "asset",
                                              assetID: "4d8c508b-91c5-375b-92b0-ee702ed2dac5",
                                              chainID: "43d61dcd-e413-450d-80b8-101d5e903357",
                                              symbol: "USDT",
                                              name: "Tether USD",
                                              iconURL: "https://mixin-images.zeromesh.net/ndNBEpObYs7450U08oAOMnSEPzN66SL8Mh-f2pPWBDeWaKbXTPUIdrZph7yj8Z93Rl8uZ16m7Qjz-E-9JFKSsJ-F=s128",
                                              balance: "10",
                                              destination: "0x718e4A7194078Ce513574Ce21Acd0381bD755A4d",
                                              tag: "",
                                              priceBtc: "",
                                              priceUsd: "",
                                              changeBtc: "",
                                              changeUsd: "",
                                              assetKey: "0xdac17f958d2ee523a2206206994597c13d831ec7",
                                              mixinID: "",
                                              confirmations: 100,
                                              capitalization: 0))
    }
}
