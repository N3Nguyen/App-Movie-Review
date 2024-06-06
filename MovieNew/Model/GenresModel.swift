import Foundation

struct GenresList: Codable {
    let genres: [GenresInfo]
}

struct GenresInfo: Codable {
    let genresID: Int
    let name: String
    
    enum CodingKeys: String, CodingKey {
        case genresID = "id"
        case name
    }
}
