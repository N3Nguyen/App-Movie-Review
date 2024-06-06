import Foundation
struct CategoryList: Codable {
    let results: [CategoryMovie]
}

struct CategoryMovie: Codable, Equatable {
    let backdropPath: String?
    let posterPath: String?
    let originalTitle: String?
    let movieID: Int
    let overview: String?
    let releaseDate: String?
    var isFavorited: Bool = false
    
    enum CodingKeys: String, CodingKey {
        case backdropPath = "backdrop_path"
        case posterPath = "poster_path"
        case originalTitle = "original_title"
        case movieID = "id"
        case overview
        case releaseDate = "release_date"
    }
}
