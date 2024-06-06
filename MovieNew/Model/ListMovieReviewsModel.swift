import Foundation

// MARK: - ListTitleReview
class ListTitleReview: Codable {
    let id: Int?
    let page: Int?
    let results: [ListTitleResult]?
    let totalPages: Int?
    let totalResults: Int?

    enum CodingKeys: String, CodingKey {
        case id = "id"
        case page = "page"
        case results = "results"
        case totalPages = "total_pages"
        case totalResults = "total_results"
    }

    init(id: Int?, page: Int?, results: [ListTitleResult]?, totalPages: Int?, totalResults: Int?) {
        self.id = id
        self.page = page
        self.results = results
        self.totalPages = totalPages
        self.totalResults = totalResults
    }
}

// MARK: - ListTitleResult
class ListTitleResult: Codable {
    let author: String?
    let authorDetails: ListTitleAuthorDetails?
    let content: String?
    let createdAt: String?
    let id: String?
    let updatedAt: String?
    let url: String?

    enum CodingKeys: String, CodingKey {
        case author = "author"
        case authorDetails = "author_details"
        case content = "content"
        case createdAt = "created_at"
        case id = "id"
        case updatedAt = "updated_at"
        case url = "url"
    }

    init(author: String?, authorDetails: ListTitleAuthorDetails?, content: String?, createdAt: String?, id: String?, updatedAt: String?, url: String?) {
        self.author = author
        self.authorDetails = authorDetails
        self.content = content
        self.createdAt = createdAt
        self.id = id
        self.updatedAt = updatedAt
        self.url = url
    }
}

// MARK: - ListTitleAuthorDetails
class ListTitleAuthorDetails: Codable {
    let name: String?
    let username: String?
    let avatarPath: String?
    var rating: Int?

    enum CodingKeys: String, CodingKey {
        case name = "name"
        case username = "username"
        case avatarPath = "avatar_path"
        case rating = "rating"
    }

    init(name: String?, username: String?, avatarPath: String?, rating: Int?) {
        self.name = name
        self.username = username
        self.avatarPath = avatarPath
        self.rating = rating
    }
}
