import Foundation


@propertyWrapper
struct FileStorage<T: Codable> {
    var value: T?
    
    let directory: FileManager.SearchPathDirectory
    let fileName: String
    
    init(directory: FileManager.SearchPathDirectory, fileName: String) {
        value = try? FileHelper.loadJSON(from: directory, fileName: fileName)
        self.directory = directory
        self.fileName = fileName
    }
    
    var wrappedValue: T? {
        set {
            value = newValue
            if let value = newValue {
                try? FileHelper.writeJSON(value, to: directory, fileName: fileName)
            } else {
                try? FileHelper.delete(from: directory, fileName: fileName)
            }
        }
        get { value }
    }
}

@propertyWrapper
struct BundleJSONStorage<T: Codable> {
    var value: T?
    
    init(forResource: String, type: String) {
        if let url =  Bundle.main.url(forResource: forResource, withExtension: type) {
            value = try? FileHelper.loadJSON(from: url)
        }
        
    }
    
    var wrappedValue: T? {
        set {
            value = newValue
        }
        get { value }
    }
}
