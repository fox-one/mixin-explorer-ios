import Foundation
import Combine

struct LoadingDetailRequest {
    let assetId: String
    
    var publisher: AnyPublisher<AssetDetail, AppError>  {
        goPublisher()
            .mapError {AppError.networkingFailed($0)}
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
    
    func goPublisher() -> AnyPublisher<AssetDetail, Error> {
        URLSession.shared
            .dataTaskPublisher(for: URL(string: "\(serverAPI())/network/assets/\(assetId)")!)
            .map { $0.data }
            .decode(type: NetworkList<AssetDetail>.self, decoder: appDecoder)
            .map({ res -> AssetDetail in
                return res.data
            })
            
            .eraseToAnyPublisher()
    }
}
