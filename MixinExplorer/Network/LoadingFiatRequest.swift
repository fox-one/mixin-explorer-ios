import Foundation
import Combine

struct LoadingFiatRequest {
    var publisher: AnyPublisher<[Fiat], AppError>  {
        goPublisher()
            .mapError {AppError.networkingFailed($0)}
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
    
    func goPublisher() -> AnyPublisher<[Fiat], Error> {
        var request = URLRequest(url: URL(string: "\(serverAPI())/fiats")!)
        request.setValue("Bearer eyJhbGciOiJSUzUxMiIsInR5cCI6IkpXVCJ9.eyJleHAiOjI1Mjg2ODk5ODcsImlhdCI6MTU4MjYwOTk4NywianRpIjoiNjJhNjg1NDQtOTA4OS00ZWYzLTkxMGYtMjEwNDQ4OGJmODJlIiwic2NwIjoiRlVMTCIsInNpZCI6ImRiMmYzMmJiLWYyYTUtNDJiMS1iOTQ2LTYzYTRlMTI5YjAyYyIsInNpZyI6ImNjNWY5ZjNlYjVmYTdlZWQ3NzlmZGYyMWQwNmY5MTQzYmNhMjNhNjEyZTE0M2E1YzFjZjhmZDQzNWFmNmEwYzEiLCJ1aWQiOiI1YzRmMzBhNi0xZjQ5LTQzYzMtYjM3Yi1jMDFhYWU1MTkxYWYifQ.iNvjyf1NiIoVTjzl7eETs0ptM6OrIVWkrxD9S8aMsYtEkENO5nDLiTS0I0gi1_gJMBR9zg2STID6xJ9ySqefe-Q86et0LBM-05l-pQ_A8FQEbSfUbMq_zLhLMJ-ZoskC_855q-YAmpaFZ_Hvw0F-M3KCPtxXICqxq5UxyCkMEHQ", forHTTPHeaderField: "Authorization")
        
        return URLSession.shared.dataTaskPublisher(for: request)
            .map { $0.data }
            .decode(type: NetworkList<[Fiat]>.self, decoder: appDecoder)
            .map({ list -> [Fiat] in
                return list.data
            })
            .eraseToAnyPublisher()
    }
}
