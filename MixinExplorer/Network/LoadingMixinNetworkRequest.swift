import Foundation
import Combine

struct LoadingMixinNetworkRequest {
    var publisher: AnyPublisher<MinxinNetwork, AppError>  {
        goPublisher()
            .mapError {AppError.networkingFailed($0)}
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
    
    func goPublisher() -> AnyPublisher<MinxinNetwork, Error> {
        
        let urlComponent = URLComponents(string: "https://mixin.network/mixin-nodes-stat.json?id=1582201911978.2422")
        
        let request = URLRequest(url: urlComponent!.url!)
        
        return URLSession.shared
            .dataTaskPublisher(for: request)
            .map { $0.data }
            .decode(type: MinxinNetwork.self, decoder: appDecoder)
            .eraseToAnyPublisher()
    }
}
