import Foundation

public enum HTTPMethod: String {
    case get    = "GET"
    case post   = "POST"
    case put    = "PUT"
    case patch  = "PATCH"
    case delete = "DELETE"
}

public enum HTTPHeaderField: String {
    case authentication = "Authorization"
    case contentType = "Content-Type"
    case acceptType = "Accept"
    case acceptEncoding = "Accept-Encoding"
    case apiVersion = "apiVersion"
}

public enum HTTPHeaderValue: String {
    case applicationJson = "application/json"
}

public enum NetworkServiceError: Error {
    case badURL
    case serverError
    case authenError
    case noData
    case encodeError
    case decodeError
}
