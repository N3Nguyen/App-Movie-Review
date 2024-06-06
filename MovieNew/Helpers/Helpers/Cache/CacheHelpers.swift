import UIKit

final class CacheHelpers {
    static let shared = CacheHelpers()
    private init() {}
    // Cache should be use DBStore like Realm/coredata to store data because image and data cache are large
    private let cache = FileManager.default
    private var safeAreaInsets: UIEdgeInsets = .zero

    func cacheImage(key: String, value: UIImage) {
        let keyFormatted = key.replacingOccurrences(of: "/", with: "")
        if let dataCache = value.pngData() {
            // Create URL
            let documents = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
            let url = documents.appendingPathComponent(keyFormatted)

            do {
                // Write to Disk
                try dataCache.write(to: url)
                print("uRLSacved: \(url)")
            } catch {
                print("Unable to Write Data to Disk (\(error))")
            }
        } else {
            print("nodata")
        }
    }

    func getCache(key: String) -> UIImage? {
        let documents = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
        let url = documents.appendingPathComponent(key.replacingOccurrences(of: "/", with: ""))
        print("uRL: \(url)")
//        if let image = UIImage(contentsOfFile: url.path()) {
//            return image
//        } else {
//            return nil
//        }
        return nil
    }
}

extension CacheHelpers {
    func safeArea() -> UIEdgeInsets {
        return safeAreaInsets
    }

    func saveSafeArea(insets: UIEdgeInsets) {
        safeAreaInsets = insets
    }
}
