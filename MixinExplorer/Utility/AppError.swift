import Foundation

enum AppError: Error, Identifiable {
    var id: String { localizedDescription }
    case networkingFailed(Error)
}

extension AppError: LocalizedError {
    var localizedDescription: String {
        switch self {
        case .networkingFailed(let error):
            return error.localizedDescription
        }
    }
}
