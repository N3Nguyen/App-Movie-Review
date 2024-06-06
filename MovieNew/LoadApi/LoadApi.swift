import Foundation
import UIKit


final class ConnectToServer {
    static let shared = ConnectToServer()
    private let defaultSession = URLSession(configuration: .default)
    private var dataTask: URLSessionDataTask?
    private var downloadTask: URLSessionDownloadTask?

    private let getImageURL = "https://image.tmdb.org/t/p/w500"
    private let cache = NSCache<NSString, UIImage>()

    func fetchData(_ url: String, handler: @escaping (Data?, String?) -> Void) {
        guard let url = URL(string: url) else {
            handler(nil, "URL Error")
            return
        }
        dataTask = defaultSession.dataTask(with: url) { data, _, error in
            if let error = error {
                print("Error \(error)")
            }
            guard let data = data else {
                return
            }
            DispatchQueue.main.async { // Make sure you're on the main thread here
                handler(data, nil)
            }
        }
        dataTask?.resume()
    }

    func downloadImageFromURL(_ path: String, complitionHandler: @escaping (UIImage?, String?) -> Void) {
        // MARK: Check data if it exist in cache, get from cache, else download and save to cache
        if let imageFromCache = cache.object(forKey: path as NSString) {
            complitionHandler(imageFromCache, nil)
        } else {
            guard let url = URL(string: "\(getImageURL)\(path)") else {
                return
            }
            var request = URLRequest(url: url, cachePolicy: .useProtocolCachePolicy, timeoutInterval: 60.0)
            request.httpMethod = "GET"
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
            downloadTask = defaultSession.downloadTask(with: request, completionHandler: { (localURL, _, error) in
                if let imageURL = localURL {
                    do {
                        let imageData = try Data(contentsOf: imageURL)
                        if let image = UIImage(data: imageData) {
                            complitionHandler(image, nil)
                            self.cache.setObject(image, forKey: path as NSString)
                        } else {
                            complitionHandler(nil, "Error")
                        }
                    } catch let error {
                        complitionHandler(nil, error.localizedDescription)
                    }
                } else {
                    complitionHandler(nil, "Error")
                }
            })
            downloadTask?.resume()
        }

    }
}
