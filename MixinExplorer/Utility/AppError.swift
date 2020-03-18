import Foundation

enum AppError: Error, Identifiable {
    var id: String { localizedDescription }
    case networkingFailed(Error)
    case loadMixinAssetsFailed(Error)
    
    case laodMixinAssetFailed(Error)
    
    case loadSnapshotsFailed(Error)
    
    case loadSnapshotFailed(Error)
    
    case loadCoinMarketFailed(Error)
    case loadVerifyTokenFailed(Error)
    case loadMixinNodeDoneFailed(Error)
    case loadMixinTopAssetsFailed(Error)
    case searchAssetsFailed(Error)
    case loadFiatFailed(Error)
    
}

extension AppError: LocalizedError {
    var localizedDescription: String {
        switch self {
        case .networkingFailed(let error):
            return error.localizedDescription
        case .loadMixinAssetsFailed(let error):
            return error.localizedDescription
        case .laodMixinAssetFailed(let error):
            return error.localizedDescription
        case .loadSnapshotsFailed(let error):
            return error.localizedDescription
        case .loadSnapshotFailed(let error):
            return error.localizedDescription
        case .loadCoinMarketFailed(let error):
            return error.localizedDescription
        case .loadVerifyTokenFailed(let error):
            return error.localizedDescription
        case .loadMixinNodeDoneFailed(let error):
            return error.localizedDescription
        case .loadMixinTopAssetsFailed(let error):
            return error.localizedDescription
        case .searchAssetsFailed(let error):
            return error.localizedDescription
        case .loadFiatFailed(let error):
            return error.localizedDescription
        }
    }
}
