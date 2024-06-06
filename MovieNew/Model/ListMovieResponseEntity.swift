
import Foundation
import CoreData


// MARK: - ListMovieResponseEntity
struct ListMovies: Codable {
    let page: Int
    let results: [MovieEntity]
    let totalResults: Int64?
    let totalPages: Int64?
    
    enum CodingKeys: String, CodingKey {
        case page
        case results
        case totalResults = "total_results"
        case totalPages = "total_pages"
    }
}

// MARK: - Result
struct MovieEntity: Codable, Equatable {
    var adult: Bool?
    var backdropPath: String?
    var genreIDS: [Int]?
    var id: Int?
    var originalLanguage, originalTitle, overview: String?
    var popularity: Double?
    var posterPath, releaseDate, title: String?
    var video: Bool?
    var voteAverage: Double?
    var voteCount: Int?

    private enum CodingKeys: String, CodingKey {
        case adult = "adult"
        case backdropPath = "backdrop_path"
        case genreIDS = "genre_ids"
        case id = "id"
        case originalLanguage = "original_language"
        case originalTitle = "original_title"
        case overview, popularity
        case posterPath = "poster_path"
        case releaseDate = "release_date"
        case title = "title"
        case video = "video"
        case voteAverage = "vote_average"
        case voteCount = "vote_count"
    }
}

struct ListMovieRequestEntity {
    static let apiKey = "api_key"
    static let page = "page"
}

struct SearchMovieRequestEntity: Codable {
    let apiKey: String
    let query: String
    let page: Int
    
    private enum CodingKeys: String, CodingKey {
        case apiKey = "api_key"
        case query
        case page
    }
    
}

struct DetailMovieRequestEntity: Codable {
    let apiKey: String
    
    private enum CodingKeys: String, CodingKey {
        case apiKey = "api_key"
    }
    
}

struct SimilarMovieRequestEntity: Codable {
    let apiKey: String
    let page: Int
    
    private enum CodingKeys: String, CodingKey {
        case apiKey = "api_key"
        case page
    }
    
}

struct DetailGenresRequestEntity: Codable {
    let apiKey: String
    let idGenres: Int
    let page: Int
    
    private enum CodingKeys: String, CodingKey {
        case apiKey = "api_key"
        case idGenres = "with_genres"
        case page
    }
}

// MARK: - ListTitleSearch
class ListTitleSearch: Codable {
    let adult: Bool?
    let backdropPath: String?
    let belongsToCollection: ListTitleBelongsToCollection?
    let budget: Int?
    let genres: [ListTitleGenre]?
    let homepage: String?
    let id: Int?
    let imdbID: String?
    let originalLanguage: String?
    let originalTitle: String?
    let overview: String?
    let popularity: Double?
    let posterPath: String?
    let productionCompanies: [ListTitleProductionCompany]?
    let productionCountries: [ListTitleProductionCountry]?
    let releaseDate: String?
    let revenue: Int?
    let runtime: Int?
    let spokenLanguages: [ListTitleSpokenLanguage]?
    let status: String?
    let tagline: String?
    let title: String?
    let video: Bool?
    let voteAverage: Double?
    let voteCount: Int?

    enum CodingKeys: String, CodingKey {
        case adult = "adult"
        case backdropPath = "backdrop_path"
        case belongsToCollection = "belongs_to_collection"
        case budget = "budget"
        case genres = "genres"
        case homepage = "homepage"
        case id = "id"
        case imdbID = "imdb_id"
        case originalLanguage = "original_language"
        case originalTitle = "original_title"
        case overview = "overview"
        case popularity = "popularity"
        case posterPath = "poster_path"
        case productionCompanies = "production_companies"
        case productionCountries = "production_countries"
        case releaseDate = "release_date"
        case revenue = "revenue"
        case runtime = "runtime"
        case spokenLanguages = "spoken_languages"
        case status = "status"
        case tagline = "tagline"
        case title = "title"
        case video = "video"
        case voteAverage = "vote_average"
        case voteCount = "vote_count"
    }

    init(adult: Bool?, backdropPath: String?, belongsToCollection: ListTitleBelongsToCollection?, budget: Int?, genres: [ListTitleGenre]?, homepage: String?, id: Int?, imdbID: String?, originalLanguage: String?, originalTitle: String?, overview: String?, popularity: Double?, posterPath: String?, productionCompanies: [ListTitleProductionCompany]?, productionCountries: [ListTitleProductionCountry]?, releaseDate: String?, revenue: Int?, runtime: Int?, spokenLanguages: [ListTitleSpokenLanguage]?, status: String?, tagline: String?, title: String?, video: Bool?, voteAverage: Double?, voteCount: Int?) {
        self.adult = adult
        self.backdropPath = backdropPath
        self.belongsToCollection = belongsToCollection
        self.budget = budget
        self.genres = genres
        self.homepage = homepage
        self.id = id
        self.imdbID = imdbID
        self.originalLanguage = originalLanguage
        self.originalTitle = originalTitle
        self.overview = overview
        self.popularity = popularity
        self.posterPath = posterPath
        self.productionCompanies = productionCompanies
        self.productionCountries = productionCountries
        self.releaseDate = releaseDate
        self.revenue = revenue
        self.runtime = runtime
        self.spokenLanguages = spokenLanguages
        self.status = status
        self.tagline = tagline
        self.title = title
        self.video = video
        self.voteAverage = voteAverage
        self.voteCount = voteCount
    }
}

// MARK: - ListTitleBelongsToCollection
class ListTitleBelongsToCollection: Codable {
    let id: Int?
    let name: String?
    let posterPath: String?
    let backdropPath: String?

    enum CodingKeys: String, CodingKey {
        case id = "id"
        case name = "name"
        case posterPath = "poster_path"
        case backdropPath = "backdrop_path"
    }

    init(id: Int?, name: String?, posterPath: String?, backdropPath: String?) {
        self.id = id
        self.name = name
        self.posterPath = posterPath
        self.backdropPath = backdropPath
    }
}

// MARK: - ListTitleGenre
class ListTitleGenre: Codable {
    let id: Int?
    let name: String?

    enum CodingKeys: String, CodingKey {
        case id = "id"
        case name = "name"
    }

    init(id: Int?, name: String?) {
        self.id = id
        self.name = name
    }
}

// MARK: - ListTitleProductionCompany
class ListTitleProductionCompany: Codable {
    let id: Int?
    let logoPath: String?
    let name: String?
    let originCountry: String?

    enum CodingKeys: String, CodingKey {
        case id = "id"
        case logoPath = "logo_path"
        case name = "name"
        case originCountry = "origin_country"
    }

    init(id: Int?, logoPath: String?, name: String?, originCountry: String?) {
        self.id = id
        self.logoPath = logoPath
        self.name = name
        self.originCountry = originCountry
    }
}

// MARK: - ListTitleProductionCountry
class ListTitleProductionCountry: Codable {
    let iso3166_1: String?
    let name: String?

    enum CodingKeys: String, CodingKey {
        case iso3166_1 = "iso_3166_1"
        case name = "name"
    }

    init(iso3166_1: String?, name: String?) {
        self.iso3166_1 = iso3166_1
        self.name = name
    }
}

// MARK: - ListTitleSpokenLanguage
class ListTitleSpokenLanguage: Codable {
    let englishName: String?
    let iso639_1: String?
    let name: String?

    enum CodingKeys: String, CodingKey {
        case englishName = "english_name"
        case iso639_1 = "iso_639_1"
        case name = "name"
    }

    init(englishName: String?, iso639_1: String?, name: String?) {
        self.englishName = englishName
        self.iso639_1 = iso639_1
        self.name = name
    }
}
