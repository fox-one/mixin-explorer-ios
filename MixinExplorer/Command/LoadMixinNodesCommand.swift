import Foundation

struct LoadMixinNodesCommand: AppCommand {
    
    func execute(in store: Store) {
        let token = SubscriptionToken()
        LoadingMixinNetworkRequest()
            .publisher.sink(receiveCompletion: { complete in
                   if case .failure(let error) = complete {
                       store.dispatch(.loadMixineNodeDone(result: .failure(error)))
                   }
                token.unseal()
            }, receiveValue: { value in
                store .dispatch(.loadMixineNodeDone(result: .success(value)))
            })
            .seal(in: token)
    }
}
