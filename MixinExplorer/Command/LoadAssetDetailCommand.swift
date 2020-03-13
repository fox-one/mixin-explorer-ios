import Foundation

struct LoadAssetDetailCommand: AppCommand {
    let assetId: String
    
     func execute(in store: Store) {
        let token = SubscriptionToken()
        LoadingDetailRequest(assetId: assetId)
            .publisher
            .sink(receiveCompletion: { complete in
                if case .failure(let error) = complete {
                    store.dispatch(.laodMixinAssetDone(result: .failure(error)))
                }
                token.unseal()
        }) { value in
            store.dispatch(.laodMixinAssetDone(result: .success(value)))
        }.seal(in: token)
    }
}
