import Foundation

// MARK: - Welcome
struct CoinMarketResponse: Codable {
    let status: Status
    let data: CoinMarketCoin
    
    enum CodingKeys: String, CodingKey {
        case status = "status"
        case data = "data"
    }
}

struct CoinMarketCoin: Codable {
    var coin: Btc
    init(from decoder: Decoder) throws {
        let dynamicKeysContainer = try decoder.container(keyedBy: DynamicKey.self)
        var coina: Btc?
        try dynamicKeysContainer.allKeys.forEach { key in
            coina = try dynamicKeysContainer.decode(Btc.self, forKey: key)
        }
        self.coin = coina!
    }
    
}


struct DynamicKey: CodingKey {
    var intValue: Int?
    
    init?(intValue: Int) {
        self.intValue = intValue
        self.stringValue = ""
    }
    
    var stringValue: String
    init?(stringValue: String) {
        self.stringValue = stringValue
        self.intValue = nil
    }
}

// MARK: - Btc
struct Btc: Codable {
    let id: Int
    let name: String
    let symbol: String
//    let slug: String
//    let numMarketPairs: Int
//    let dateAdded: String
//    let tags: [String]
//    let maxSupply: Double
    let circulatingSupply: Double
    let totalSupply: Double
    
//    let cmcRank: Int
//    let lastUpdated: String
    let quote: Quote
    
    enum CodingKeys: String, CodingKey {
        case id = "id"
        case name = "name"
        case symbol = "symbol"
//        case slug = "slug"
//        case numMarketPairs = "num_market_pairs"
//        case dateAdded = "date_added"
//        case tags = "tags"
//        case maxSupply = "max_supply"
        case circulatingSupply = "circulating_supply"
        case totalSupply = "total_supply"
        
//        case cmcRank = "cmc_rank"
//        case lastUpdated = "last_updated"
        case quote = "quote"
    }
}

// MARK: - Quote
struct Quote: Codable {
    let usd: QuoteUSD
    
    enum CodingKeys: String, CodingKey {
        case usd = "USD"
    }
}

// MARK: - Usd
struct QuoteUSD: Codable {
    let price: Double
    let volume24H: Double
    let percentChange1H: Double
    let percentChange24H: Double
    let percentChange7D: Double
    let marketCap: Double
    let lastUpdated: String
    
    enum CodingKeys: String, CodingKey {
        case price = "price"
        case volume24H = "volume_24h"
        case percentChange1H = "percent_change_1h"
        case percentChange24H = "percent_change_24h"
        case percentChange7D = "percent_change_7d"
        case marketCap = "market_cap"
        case lastUpdated = "last_updated"
    }
}

// MARK: - Status
struct Status: Codable {
    let timestamp: String
    let errorCode: Int
    
    let elapsed: Int
    let creditCount: Int
    
    enum CodingKeys: String, CodingKey {
        case timestamp = "timestamp"
        case errorCode = "error_code"
        case elapsed = "elapsed"
        case creditCount = "credit_count"
        
    }
}
