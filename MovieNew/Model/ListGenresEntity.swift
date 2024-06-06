import Foundation

import Foundation

struct ListGenresResponseEntity: Codable {
    let genres: [ListGenresEntity]
    
    private enum CodingKeys: String, CodingKey {
        case genres = "genres"
    }
}

struct ListGenresEntity: Codable, Equatable {
    let id: Int
    let name: String
    
    private enum CodingKeys: String, CodingKey {
        case id = "id"
        case name = "name"
    }
}

struct ListGenresRequestEntity {
    static let apiKey = "api_key"
}
