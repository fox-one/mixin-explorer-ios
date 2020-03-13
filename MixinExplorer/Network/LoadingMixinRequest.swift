import Foundation
import Combine

func isRegionChina() -> Bool {
    if let region = Locale.current.regionCode, region == "CN" {
        return true
    }
    return false
}

func serverAPI() -> String {
    return isRegionChina() ? "https://mixin-api.zeromesh.net" : "https://api.mixin.one"
}

struct LoadingMixinRequest {
    var publisher: AnyPublisher<MixinNetworkAsset, AppError>  {
        goPublisher()
            .mapError {AppError.networkingFailed($0)}
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
    
    func goPublisher() -> AnyPublisher<MixinNetworkAsset, Error> {
        URLSession.shared
            .dataTaskPublisher(for: URL(string: "\(serverAPI())/network")!)
            .map { $0.data }
            .decode(type: NetworkList<MixinNetworkAsset>.self, decoder: appDecoder)
            .map({ list -> MixinNetworkAsset in
                print(list)
                return list.data
            })
            
            .eraseToAnyPublisher()
    }
}

