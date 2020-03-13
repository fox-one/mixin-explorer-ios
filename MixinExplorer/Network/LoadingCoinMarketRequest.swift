import Foundation
import Combine

struct LoadingCoinMarketRequest {
    let symbol: String
    var publisher: AnyPublisher<CoinMarketResponse, AppError>  {
        goPublisher()
            .mapError {AppError.networkingFailed($0)}
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
    
    func goPublisher() -> AnyPublisher<CoinMarketResponse, Error> {
        
        var urlComponent = URLComponents(string: "https://pro-api.coinmarketcap.com/v1/cryptocurrency/quotes/latest")
        urlComponent?.queryItems = [ URLQueryItem(name: "symbol", value: "\(symbol.uppercased())")]
        
        var request = URLRequest(url: urlComponent!.url!)
        request.setValue("cfb57c9b-02e2-4b64-891e-df9dac34ef6c", forHTTPHeaderField: "X-CMC_PRO_API_KEY")
        
        return URLSession.shared
            .dataTaskPublisher(for: request)
            .map { $0.data }
            .decode(type: CoinMarketResponse.self, decoder: appDecoder)
            .eraseToAnyPublisher()
    }
}
