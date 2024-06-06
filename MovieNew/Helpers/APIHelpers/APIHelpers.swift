////
////  APIHelpers.swift
////  Smart Movie
////
////  Created by GST on 08/06/2023.
////
//
//import UIKit
//
//final class APIHelpers {
//    static let shared = APIHelpers()
//    private init() {}
//    private let defaultSession = URLSession(configuration: .default)
//    private var downloadTask: URLSessionDownloadTask?
//    
//    // GET method: request with params
//    func requestGET(url: String, params: [String: String], complete: @escaping (Bool, Data?) -> ()) {
//        guard var components = URLComponents(string: url) else {
//            print("APIHelpers/requestGET/Error: cannot create URLCompontents")
//            return
//        }
//        components.queryItems = params.map { key, value in
//            URLQueryItem(name: key, value: value)
//        }
//        
//        guard let url = components.url else {
//            print("APIHelpers/requestGET/Error: cannot create URL")
//            return
//        }
//        var request = URLRequest(url: url)
//        request.httpMethod = HTTPMethod.get.rawValue
//        request.setValue(HTTPHeaderValue.applicationJson.rawValue, forHTTPHeaderField: HTTPHeaderField.contentType.rawValue)
//        
//        let session = URLSession(configuration: .default)
//        session.dataTask(with: request) { data, response, error in
//            guard error == nil else {
//                print(error!)
//                complete(false, nil)
//                return
//            }
//            guard let data = data else {
//                print("APIHelpers/requestGET/Error: did not receive data")
//                complete(false, nil)
//                return
//            }
//            guard let response = response as? HTTPURLResponse, (200 ... 299) ~= response.statusCode else {
//                print("APIHelpers/requestGET/Error: HTTP request failed")
//                complete(false, nil)
//                return
//            }
//            complete(true, data)
//        }.resume()
//    }
//    
//    func downloadImageFromURL(_ path: String, completion: @escaping (UIImage?, NetworkServiceError?) -> Void) { // MARK: Check data if it exist in cache, get from cache, else download and save to cache
//        if let imageFromCache = CacheHelpers.shared.getCache(key: path) {
//            completion(imageFromCache, nil)
//        } else {
//            guard let url = URL(string: "\(path)") else {
//                return
//            }
//            var request = URLRequest(url: url, cachePolicy: .useProtocolCachePolicy, timeoutInterval: 60.0)
//            request.httpMethod = HTTPMethod.get.rawValue
//            request.setValue(HTTPHeaderValue.applicationJson.rawValue, forHTTPHeaderField: HTTPHeaderField.contentType.rawValue)
//            downloadTask = defaultSession.downloadTask(with: request, completionHandler: { (localURL, _, error) in
//                if let imageURL = localURL {
//                    do {
//                        let imageData = try Data(contentsOf: imageURL)
//                        if let image = UIImage(data: imageData) {
//                            CacheHelpers.shared.cacheImage(key: path, value: image)
//                            completion(image, nil)
//                        } else {
//                            completion(nil, .noData)
//                        }
//                    } catch {
//                        completion(nil, .serverError)
//                    }
//                } else {
//                    completion(nil, .badURL)
//                }
//            })
//            downloadTask?.resume()
//        }
//    }
//}
