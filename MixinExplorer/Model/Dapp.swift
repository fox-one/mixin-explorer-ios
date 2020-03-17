import Foundation

struct Dapp: Codable, Identifiable, Hashable {
    var id: String { return "\(self)" }
    
    let title: String
    let subTitle: String
    let iconURL: String
    let url: String
    
    enum CodingKeys: String, CodingKey {
        case title
        case subTitle = "sub_title"
        case iconURL = "icon_url"
        case url
    }
}


struct Dapps: Codable, Identifiable {
    var id: String { return "\(self)" }
    let banner: [Banner]
    let section: [DappSection]
}

// MARK: - Banner
struct Banner: Codable, Identifiable {
    var id: String { return "\(self)" }
    let title, subtitle, iconURL, url: String

    enum CodingKeys: String, CodingKey {
        case title, subtitle, url
        case iconURL = "icon_url"
    }
}

// MARK: - Section
struct DappSection: Codable, Identifiable {
    var id: String { return "\(self)" }
    let title: String
    let data: [Dapp]
}
