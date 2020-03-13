import Foundation

struct LoadSnapshotCommand: AppCommand {
    let snapshotID: String
    
     func execute(in store: Store) {
        let token = SubscriptionToken()
        LoadingSnapshotRequest(snapshotId: snapshotID)
            .publisher
            .sink(receiveCompletion: { complete in
                if case .failure(let error) = complete {
                    store.dispatch(.loadSnapshotDone(result: .failure(error)))
                }
                token.unseal()
        }) { value in
            store.dispatch(.loadSnapshotDone(result: .success(value)))
        }.seal(in: token)
    }
}
