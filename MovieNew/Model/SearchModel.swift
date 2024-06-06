import Foundation
struct MovieSearchResult: Codable {
    let page: Int
    let results: [MovieSearchInfo]
}

struct MovieSearchInfo: Codable {
    let backdropPath: String?
    let originalTitle: String?
    let voteAverage: Double
    let movieID: Int
    let genresID: [Int]?
    
    enum CodingKeys: String, CodingKey {
        case backdropPath = "backdrop_path"
        case originalTitle = "original_title"
        case voteAverage = "vote_average"
        case movieID = "id"
        case genresID = "genre_ids"
    }
}
