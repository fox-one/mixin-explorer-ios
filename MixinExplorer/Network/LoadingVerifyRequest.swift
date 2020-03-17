import Foundation
import Combine

struct LoadingVerifyRequest {
    let token: String
    var publisher: AnyPublisher<[VerifyAsset], AppError>  {
        goPublisher()
            .mapError {AppError.networkingFailed($0)}
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
    
    func goPublisher() -> AnyPublisher<[VerifyAsset], Error> {
        let urlComponent = URLComponents(string: "\(serverAPI())/assets")
        var request = URLRequest(url: urlComponent!.url!)
        request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        
        return URLSession.shared
            .dataTaskPublisher(for: request)
            .map { $0.data }
            .decode(type: NetworkList<[VerifyAsset]>.self, decoder: appDecoder)
            .map({ list -> [VerifyAsset] in
                
                return list.data
            })
            .eraseToAnyPublisher()
    }
}
