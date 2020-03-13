import Foundation

struct LoadVerifyAssetCommand: AppCommand {
    let toke: String
    
     func execute(in store: Store) {
        let token = SubscriptionToken()
        LoadingVerifyRequest(token: toke)
            .publisher
            .sink(receiveCompletion: { complete in
                if case .failure(let error) = complete {
                    store.dispatch(.loadVerifyTokenDone(result: .failure(error)))
                }
                token.unseal()
        }) { value in
                store.dispatch(.loadVerifyTokenDone(result: .success(value)))
        }.seal(in: token)
    }
}
