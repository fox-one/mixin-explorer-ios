import Foundation
import Combine

struct LoadMixinTopAssetCommand: AppCommand {
    func execute(in store: Store) {
          let token = SubscriptionToken()
            LoadingTopMixinAssetRequest()
            .publisher.sink(receiveCompletion: { complete in
            if case .failure(let error) = complete {
                store.dispatch(.loadMixinTopAssetsDone(result: .failure(error)))
            }
                token.unseal()
        }, receiveValue: { value in
            store.dispatch(.loadMixinTopAssetsDone(result: .success(value)))
        })
                .seal(in: token)
    }
}
