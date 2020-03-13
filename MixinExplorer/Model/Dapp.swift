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
