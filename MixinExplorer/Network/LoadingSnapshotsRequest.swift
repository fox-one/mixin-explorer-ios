import Foundation
import Combine

struct LoadingSnapshotsRequest {
    let assetId: String
    let limit: Int = 50
    var publisher: AnyPublisher<[Snapshot], AppError>  {
        goPublisher()
            .mapError {AppError.networkingFailed($0)}
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
    
    func goPublisher() -> AnyPublisher<[Snapshot], Error> {
        
        var urlComponent = URLComponents(string: "\(serverAPI())/network/snapshots")
        urlComponent?.queryItems = [ URLQueryItem(name: "limit", value: "\(limit)"),
                                     URLQueryItem(name: "asset", value: assetId),
                                     URLQueryItem(name: "offset", value: "")]
        
        return URLSession.shared
            .dataTaskPublisher(for: URLRequest(url: urlComponent!.url!))
            .map { $0.data }
            .decode(type: NetworkList<[Snapshot]>.self, decoder: appDecoder)
            .map({ list -> [Snapshot] in
                print(list)
                return list.data
            })
            .eraseToAnyPublisher()
    }
}
