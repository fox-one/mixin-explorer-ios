import Foundation

struct LoadMixinAssetCommand: AppCommand {
    func execute(in store: Store) {
          let token = SubscriptionToken()
            LoadingMixinRequest()
            .publisher.sink(receiveCompletion: { complete in
            if case .failure(let error) = complete {
                store.dispatch(.loadMixinAssetsDone(result: .failure(error)))
            }
                token.unseal()
        }, receiveValue: { value in
            store.dispatch(.loadMixinAssetsDone(result: .success(value)))
        })
                .seal(in: token)
    }
}

