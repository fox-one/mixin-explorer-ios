import Foundation

struct MinxinNetwork: Codable {
    let nodes: [MixinNode]
    let updatedAt: String
    
    var validateCount: Int {
        return nodes.filter { $0.stat.data?.failed == nil }.count
    }
    
    var faileCount: Int {
        return nodes.filter { $0.stat.data?.failed != nil }.count
    }
}

struct MixinNode: Codable, Identifiable {
    var id: String  { return "\(self)" }
    let signer: String
    let host: String
    let name: String
    let text: String
    let stat: NodeState
}

struct NodeState: Codable {
    let code: Int
    let data: NodeStatus?
}

struct NodeStatus: Codable {
    let epoch: String?
    let graph: Graph?
    let network: String?
    let node: String?
    let pool: String?
    let queue: Queue?
    let timestamp: String?
    let failed: String?
    let uptime: String?
    let version: String?
    
    var date: Date {
        let formatter = ISO8601DateFormatter()
        if let timestamp = timestamp {
              return formatter.date(from: timestamp) ?? Date()
        } else {
            return Date()
        }
      
    }
}

struct Graph: Codable {
//    let cache: [String: Cache]
//    let consensus: [Consensus]
//    let graphFinal: [String: Final]
    let topology: Int
}

//// MARK: - Cache
//struct Cache: Codable {
//    let node: String
//    let round: Int
//    let snapshots: [Snapshot]
//    let timestamp: Double
//
//    enum CodingKeys: String, CodingKey {
//        case node = "node"
//        case round = "round"
//        case snapshots = "snapshots"
//        case timestamp = "timestamp"
//    }
//}




// MARK: - Snapshot
//struct Snapshot: Codable {
//    let version: Int
//    let node: String
//    let transaction: String
//    let references: References
//    let round: Int
//    let timestamp: Double
//    let signature: String
//    let hash: String
//
//    enum CodingKeys: String, CodingKey {
//        case version = "version"
//        case node = "node"
//        case transaction = "transaction"
//        case references = "references"
//        case round = "round"
//        case timestamp = "timestamp"
//        case signature = "signature"
//        case hash = "hash"
//    }
//}

// MARK: - Consensus
struct Consensus: Codable {
    let node: String
    let payee: String
    let signer: String
//    let state: State
    let timestamp: Double
    let transaction: String

}

//enum State: String, Codable {
//    case accepted = "ACCEPTED"
//}

// MARK: - Final
struct Final: Codable {
    let end: Double
    let hash: String
    let node: String
    let round: Int
    let start: Double

//    enum CodingKeys: String, CodingKey {
//        case end = "end"
//        case hash = "hash"
//        case node = "node"
//        case round = "round"
//        case start = "start"
//    }
}

// MARK: - Queue
struct Queue: Codable {
    let caches: Int
    let finals: Int

//    enum CodingKeys: String, CodingKey {
//        case caches = "caches"
//        case finals = "finals"
//    }
}
