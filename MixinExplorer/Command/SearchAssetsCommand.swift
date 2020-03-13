import Foundation
import Combine

struct SearchAssetsCommand: AppCommand {
    let symbol: String
    func execute(in store: Store) {
        let token = SubscriptionToken()
        SearchAssetsRequest(symbol: symbol)
            .publisher.sink(receiveCompletion: { complete in
                if case .failure(let error) = complete {
                    store.dispatch(.searchAssetsDone(result: .failure(error)))
                }
                token.unseal()
            }, receiveValue: { value in
                store.dispatch(.searchAssetsDone(result: .success(value)))
            })
            .seal(in: token)
    }
}
