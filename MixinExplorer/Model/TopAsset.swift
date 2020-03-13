import Foundation

public struct TopAsset: Codable, Identifiable {
    public var id: String  { return "\(self)" }
    public let type: String
    public let assetId: String
    public let chainId: String
    public let symbol: String
    public let name: String
    public let iconURL: String
    public let balance: String
    public let destination: String
    public let tag: String
    public let priceBTC: String
    public let priceUSD: String
    public let changeBTCPercentage: String
    public let changeUSDPercentage: String
    public let assetKey: String
    public let confirmations: Int
    public let capitalization: Double
    
    var amountValue: Double {
        if let price = Double(priceUSD), !price.isZero {
            return capitalization / price
        } else {
            return capitalization
        }
     }
    
    enum CodingKeys: String, CodingKey {
        case type = "type"
        case assetId = "asset_id"
        case chainId = "chain_id"
        case symbol = "symbol"
        case name = "name"
        case iconURL = "icon_url"
        case balance = "balance"
        case destination = "destination"
        case tag = "tag"
        case priceBTC = "price_btc"
        case priceUSD = "price_usd"
        case changeBTCPercentage = "change_btc"
        case changeUSDPercentage = "change_usd"
        case assetKey = "asset_key"
        case confirmations = "confirmations"
        case capitalization = "capitalization"
    }
    
    var marketCap: String {
        let caps: Int = Int(capitalization)
        
        return caps.formatUsingAbbrevation()
    }
}

extension Int {

    func formatUsingAbbrevation () -> String {
        let numFormatter = NumberFormatter()

        typealias Abbrevation = (threshold:Double, divisor:Double, suffix:String)
        let abbreviations:[Abbrevation] = [(0, 1, ""),
                                           (1000.0, 1000.0, "K"),
                                           (100_000.0, 1_000_000.0, "M"),
                                           (100_000_000.0, 1_000_000_000.0, "B"),
                                           (100_000_000_000.0, 1_000_000_000_000.0, "T")]

        let startValue = Double (abs(self))
        let abbreviation:Abbrevation = {
            var prevAbbreviation = abbreviations[0]
            for tmpAbbreviation in abbreviations {
                if (startValue < tmpAbbreviation.threshold) {
                    break
                }
                prevAbbreviation = tmpAbbreviation
            }
            return prevAbbreviation
        } ()

        let value = Double(self) / abbreviation.divisor
        numFormatter.positiveSuffix = abbreviation.suffix
        numFormatter.negativeSuffix = abbreviation.suffix
        numFormatter.allowsFloats = true
        numFormatter.minimumIntegerDigits = 1
        numFormatter.minimumFractionDigits = 0
        numFormatter.maximumFractionDigits = 1

        return numFormatter.string(from: NSNumber(value:value))!
    }

}
