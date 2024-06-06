import Foundation

struct ListCategoryResponseEntity: Codable, Equatable {
    let cast , crew: [ListCastResponseEntitty]
    
    private enum CodingKeys: String, CodingKey {
        case cast = "cast"
        case crew = "crew"
    }
}

struct ListCastResponseEntitty: Codable, Equatable {
    let gender, id: Int
    let knownForDepartment, name, originalName: String
    let profilePath: String?
    let character: String?
    let job: String?
    
    enum CodingKeys: String, CodingKey {
        case gender, id
        case knownForDepartment = "known_for_department"
        case name = "name"
        case originalName = "original_name"
        case profilePath = "profile_path"
        case character = "character"
        case job = "job"
    }
}
