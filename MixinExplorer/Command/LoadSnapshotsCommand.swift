
import Foundation

struct LoadSnapshotsCommand: AppCommand {
    let assetId: String
    
     func execute(in store: Store) {
        let token = SubscriptionToken()
        LoadingSnapshotsRequest(assetId: assetId)
            .publisher
            .sink(receiveCompletion: { complete in
                if case .failure(let error) = complete {
                    store.dispatch(.loadSnapshotsDone(result: .failure(error)))
                }
                token.unseal()
        }) { value in
            store.dispatch(.loadSnapshotsDone(result: .success(value)))
        }.seal(in: token)
    }
}
