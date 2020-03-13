import SwiftUI
import Kingfisher
import Foundation

struct AssetRowView: SwiftUI.View {
    @EnvironmentObject var store: Store
    let model: TopAsset
    var body: some SwiftUI.View {
        HStack(spacing: 8) {
            ZStack {
                KFImage(URL(string: model.iconURL))
                    .placeholder{
                        SwiftUI.Image("placeholder")
                            .resizable()
                            .frame(width: 36.0, height: 36.0)
                            .aspectRatio(contentMode: .fit)
                }
                .resizable()
                .frame(width: 36.0, height: 36.0)
                .cornerRadius(18)
                .aspectRatio(contentMode: .fit)
                KFImage(getChainIcon())
                    .placeholder{
                        SwiftUI.Image("placeholder")
                            .resizable()
                            .frame(width: 10, height: 10)
                            .aspectRatio(contentMode: .fit)
                }
                .resizable()
                .frame(width: 10, height: 10)
                .cornerRadius(6)
                .aspectRatio(contentMode: .fit)
                .offset(x: 12, y: 12)
            }
            
            HStack(alignment: .center, spacing: 0.0) {
                Text(model.symbol)
                    .frame(maxWidth: 100, alignment: .leading)
                    .foregroundColor(Color(.label))
                    .font(Font.system(size: 18, weight: .bold))
                VStack {
                    Text("\(getAmountValue()) \(model.symbol)")
                        .frame(maxWidth: .infinity, alignment: .trailing)
                        .font(Font.system(size: 16))
                        .foregroundColor(Color(.secondaryLabel))
                    HStack(alignment: .center, spacing: 0.0) {
                        Text("\(model.marketCap) USD")
                            .frame(maxWidth: .infinity, alignment: .trailing)
                            .font(Font.system(size: 16))
                            .foregroundColor(Color(.secondaryLabel))
                    }
                }.padding(EdgeInsets(top: 0, leading: 8, bottom: 0, trailing: 0))
            }
        }
        .padding(EdgeInsets(top: 8, leading: 0, bottom: 8, trailing: 0))
    }
    
    func getAmountValue() -> String {
        var value: Double = 0
        
        if let asset = store.appState.mixinNetworkAssetList.assetMap[model.assetId] {
            value = asset.amountValue
        } else {
            value = model.amountValue
        }
        
        return value.decimalFormatter
    }
    
    func getChainIcon() -> URL? {
        if let chain = store.appState.mixinNetworkAssetList.chainMap[model.chainId] {
            
            return URL(string: chain.iconURL)
            
        }
        return nil
    }
}

class DecimalFormatterManager {
    let formatter = NumberFormatter()
    static let shared = DecimalFormatterManager()
    
    init() {
        self.formatter.numberStyle = .decimal
        self.formatter.minimumFractionDigits = 2
        self.formatter.maximumFractionDigits = 2
        self.formatter.roundingMode = .floor
        self.formatter.usesGroupingSeparator = true
        self.formatter.locale = Locale.current
    }
    
    func decimalFormatterWithDouble(value: Double) -> String {
        return self.formatter.string(from: NSNumber(value: value)) ?? "0.00"
    }
}

public extension Double {
    var decimalFormatter: String {
        return DecimalFormatterManager.shared.decimalFormatterWithDouble(value: self)
    }
}


struct MixinAssetRow_Previews: PreviewProvider {
    static var previews: some SwiftUI.View {
        let asset = TopAsset(type: "a", assetId: "a", chainId: "a", symbol: "1", name: "a", iconURL: "a", balance: "100", destination: "", tag: "", priceBTC: "100", priceUSD: "100", changeBTCPercentage: "100", changeUSDPercentage: "100", assetKey: "", confirmations: 100, capitalization: 100)
        
        return
            AssetRowView(model: asset)
    }
}


