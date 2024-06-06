import Foundation
import CoreData

// MARK: - ListMovieDetailEntity

struct ListMovieDetailEntity: Codable, Equatable {
    static func == (lhs: ListMovieDetailEntity, rhs: ListMovieDetailEntity) -> Bool {
        return lhs.backdropPath == rhs.backdropPath &&
               lhs.genres == rhs.genres &&
               lhs.homepage == rhs.homepage &&
               lhs.originalTitle == rhs.originalTitle &&
               lhs.overview == rhs.overview &&
               lhs.posterPath == rhs.posterPath &&
               lhs.id == rhs.id &&
               lhs.productionCountries == rhs.productionCountries &&
               lhs.releaseDate == rhs.releaseDate &&
               lhs.runtime == rhs.runtime &&
               lhs.spokenLanguages == rhs.spokenLanguages &&
               lhs.title == rhs.title &&
               lhs.voteAverage == rhs.voteAverage
    }
    
    let backdropPath: String
    let genres: [Genre]
    let homepage: String
    let originalTitle, overview: String
    let posterPath: String
    let id: Int
    let productionCountries: [ProductionCountry]
    let releaseDate: String
    let runtime: Int
    let spokenLanguages: [SpokenLanguage]
    let title: String
    let voteAverage: Double

    private enum CodingKeys: String, CodingKey {
        case backdropPath = "backdrop_path"
        case genres = "genres"
        case homepage = "homepage"
        case originalTitle = "original_title"
        case overview = "overview"
        case id = "id"
        case posterPath = "poster_path"
        case productionCountries = "production_countries"
        case releaseDate = "release_date"
        case runtime = "runtime"
        case spokenLanguages = "spoken_languages"
        case title = "title"
        case voteAverage = "vote_average"
    }
    
}

// MARK: - Genre
struct Genre: Codable, Equatable {
    let id: Int
    let name: String
    
    enum CodingKeys: String, CodingKey {
        case id = "id"
        case name = "name"
    }
}

// MARK: - ProductionCountry
struct ProductionCountry: Codable, Equatable {
    let iso3166_1, name: String

    enum CodingKeys: String, CodingKey {
        case iso3166_1 = "iso_3166_1"
        case name = "name"
    }
}

// MARK: - SpokenLanguage
struct SpokenLanguage: Codable, Equatable {
    let englishName, iso639_1, name: String

    enum CodingKeys: String, CodingKey {
        case englishName = "english_name"
        case iso639_1 = "iso_639_1"
        case name
    }
}

struct DetailRequestEntity {
    static let apiKey = "api_key"
    static let query = "query"
}
