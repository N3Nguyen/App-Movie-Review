import Foundation

// MARK: - ListTitleTrailer
class ListTitleTrailer: Codable {
    let id: Int?
    let results: [ListLinkMovieResult]?

    enum CodingKeys: String, CodingKey {
        case id = "id"
        case results = "results"
    }
}

// MARK: - ListLinkMovieResult
class ListLinkMovieResult: Codable {
    let iso639_1: ListTitleISO639_1?
    let iso3166_1: ListTitleISO3166_1?
    let name: String?
    let key: String?
    let site: ListTitleSite?
    let size: Int?
    let type: String?
    let official: Bool?
    let publishedAt: String?
    let id: String?

    enum CodingKeys: String, CodingKey {
        case iso639_1 = "iso_639_1"
        case iso3166_1 = "iso_3166_1"
        case name = "name"
        case key = "key"
        case site = "site"
        case size = "size"
        case type = "type"
        case official = "official"
        case publishedAt = "published_at"
        case id = "id"
    }

    init(iso639_1: ListTitleISO639_1?, iso3166_1: ListTitleISO3166_1?, name: String?, key: String?, site: ListTitleSite?, size: Int?, type: String?, official: Bool?, publishedAt: String?, id: String?) {
        self.iso639_1 = iso639_1
        self.iso3166_1 = iso3166_1
        self.name = name
        self.key = key
        self.site = site
        self.size = size
        self.type = type
        self.official = official
        self.publishedAt = publishedAt
        self.id = id
    }
}

enum ListTitleISO3166_1: String, Codable {
    case us = "US"
}

enum ListTitleISO639_1: String, Codable {
    case en = "en"
}

enum ListTitleSite: String, Codable {
    case youTube = "YouTube"
}
