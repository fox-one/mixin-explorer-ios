import Foundation
import Combine

struct LoadingSnapshotRequest {
    let snapshotId: String
    
    var publisher: AnyPublisher<Snapshot, AppError>  {
        goPublisher()
            .mapError {AppError.networkingFailed($0)}
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
    
    func goPublisher() -> AnyPublisher<Snapshot, Error> {
        URLSession.shared
            .dataTaskPublisher(for: URL(string: "\(serverAPI())/network/snapshots/\(snapshotId)")!)
            .map { $0.data }
            .decode(type: NetworkList<Snapshot>.self, decoder: appDecoder)
            .map({ res -> Snapshot in
                return res.data
            })
            .eraseToAnyPublisher()
    }
}
