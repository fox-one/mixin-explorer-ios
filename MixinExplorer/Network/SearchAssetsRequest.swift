import Foundation
import Combine

struct SearchAssetsRequest {
    let symbol: String
    var publisher: AnyPublisher<[TopAsset], AppError>  {
        goPublisher()
            .mapError {AppError.networkingFailed($0)}
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
    
    func goPublisher() -> AnyPublisher<[TopAsset], Error> {
        URLSession.shared
            .dataTaskPublisher(for: URL(string: "\(serverAPI())/network/assets/search/\(symbol)")!)
            .map { $0.data }
            .decode(type: NetworkList<[TopAsset]>.self, decoder: appDecoder)
            .map({ list -> [TopAsset] in
                return list.data
            })
            .eraseToAnyPublisher()
    }
}
