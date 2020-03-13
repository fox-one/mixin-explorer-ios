import Foundation
import SwiftUI

enum FileHelper {
    
    static func loadBundledJSON<T: Decodable>(file: String) -> T {
        guard let url = Bundle.main.url(forResource: file, withExtension: "json") else {
            fatalError("Resource not found: \(file)")
        }
        return try! loadJSON(from: url)
    }
    
    static func loadJSON<T: Decodable>(from url: URL) throws -> T {
        let data = try Data(contentsOf: url)
        return try appDecoder.decode(T.self, from: data)
    }
    
    static func loadJSON<T: Decodable>(
        from directory: FileManager.SearchPathDirectory,
        fileName: String
    ) throws -> T
    {
        let url = FileManager.default.urls(for: directory, in: .userDomainMask).first!
        return try loadJSON(from: url.appendingPathComponent(fileName))
    }
    
    static func writeJSON<T: Encodable>(_ value: T, to url: URL) throws {
        let data = try appEncoder.encode(value)
        try data.write(to: url)
    }
    
    static func writeJSON<T: Encodable>(
        _ value: T,
        to directory: FileManager.SearchPathDirectory,
        fileName: String
    ) throws
    {
        guard let url = FileManager.default.urls(for: directory, in: .userDomainMask).first else {
            return
        }
        try writeJSON(value, to: url.appendingPathComponent(fileName))
    }
    
    static func delete(
        from directory: FileManager.SearchPathDirectory,
        fileName: String) throws
    {
        guard let url = FileManager.default.urls(for: directory, in: .userDomainMask).first else {
            return
        }
        try FileManager.default.removeItem(at: url.appendingPathComponent(fileName))
    }
}


extension Color {
    init(hex: Int, alpha: Double = 1) {
        let components = (
            R: Double((hex >> 16) & 0xff) / 255,
            G: Double((hex >> 08) & 0xff) / 255,
            B: Double((hex >> 00) & 0xff) / 255
        )
        self.init(
            .sRGB,
            red: components.R,
            green: components.G,
            blue: components.B,
            opacity: alpha
        )
    }
}

extension URL {
    var extractedID: Int? {
        Int(lastPathComponent)
    }
}

extension String {
    var newlineRemoved: String {
        return split(separator: "\n").joined(separator: " ")
    }
    
    var isValidEmailAddress: Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        
        let emailPred = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailPred.evaluate(with: self)
    }
}

let appDecoder: JSONDecoder = {
    let decoder = JSONDecoder()
//    decoder.keyDecodingStrategy = .
    return decoder
}()

let appEncoder: JSONEncoder = {
    let encoder = JSONEncoder()
    encoder.keyEncodingStrategy = .convertToSnakeCase
    return encoder
}()


public struct Application {

    fileprivate static func getString(_ key: String) -> String {
        guard let infoDictionary = Bundle.main.infoDictionary,
              let value = infoDictionary[key] as? String
                else {
            return ""
        }

        return value
    }

    public static var name: String = {
        return Application.getString("CFBundleDisplayName")
    }()

    public static var version: String = {
        return Application.getString("CFBundleShortVersionString")
    }()

    public static var build: String = {
        return Application.getString("CFBundleVersion")
    }()

    public static var executable: String = {
        return Application.getString("CFBundleExecutable")
    }()

    public static var bundleID: String = {
        return Application.getString("CFBundleIdentifier")
    }()

    public static var schemes: [String] = {
        guard let infoDictionary = Bundle.main.infoDictionary,
              let urlTypes = infoDictionary["CFBundleURLTypes"] as? [AnyObject],
              let urlType = urlTypes.first as? [String: AnyObject],
              let urlSchemes = urlType["CFBundleURLSchemes"] as? [String]
                else {
            return []
        }

        return urlSchemes
    }()

    public static var mainScheme: String? = {
        return schemes.first
    }()

    public static func appIcon() -> UIImage? {
        guard let infoDictionary = Bundle.main.infoDictionary,
              let bundleIcon = infoDictionary["CFBundleIcons"] as? [String: AnyObject],
              let primaryIcon = bundleIcon["CFBundlePrimaryIcon"] as? [String: AnyObject],
              let iconFiles = primaryIcon["CFBundleIconFiles"] as? [String],
              let iconName = iconFiles.last
                else {
            return nil
        }
        let icon: UIImage? = UIImage(named: iconName)
        return icon
    }

    public static var appUserAgent: String {
        return "\(self.name)/\(self.version).\(self.build)"
    }
}
