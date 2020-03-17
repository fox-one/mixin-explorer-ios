import Foundation
import Combine

struct LoadingFiatCommand: AppCommand {
    func execute(in store: Store) {
        let token = SubscriptionToken()
        LoadingFiatRequest()
            .publisher.sink(receiveCompletion: { complete in
                if case .failure(let error) = complete {
                    store.dispatch(.loadFiatDone(result: .failure(error)))
                }
                token.unseal()
            }, receiveValue: { value in
                store.dispatch(.loadFiatDone(result: .success(value)))
            })
            .seal(in: token)
    }
}
