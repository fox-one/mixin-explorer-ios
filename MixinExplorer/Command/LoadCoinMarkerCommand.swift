import Foundation

struct LoadCoinMarkerCommand: AppCommand {
    let symbol: String
    
     func execute(in store: Store) {
        let token = SubscriptionToken()
        LoadingCoinMarketRequest(symbol: symbol)
            .publisher
            .sink(receiveCompletion: { complete in
                if case .failure(let error) = complete {
                    store.dispatch(.loadCoinMarketDone(symbol: self.symbol, result: .failure(error)))
                }
                token.unseal()
        }) { value in
            store.dispatch(.loadCoinMarketDone(symbol: self.symbol, result: .success(value)))
        }.seal(in: token)
    }
}
