import Foundation
import UIKit
class CategoryGenres {
    
    static let shared: CategoryGenres = CategoryGenres()
    var listGenres: [ListGenresEntity] = [ListGenresEntity]()
    var onGerDataGenresSuccess: (() -> Void)?
    var onGetDataFail: ((_ error: NetworkServiceError) -> Void)?
    func getDataGenres() {
        let genreslMovieURL: String = "\(ServerConstants.baseURL)\(ServerConstants.genresList)"
        let params = [DetailRequestEntity.apiKey : ServerConstants.apiKey]
        APIHelpers.shared.requestGET(url: genreslMovieURL, params: params) { success, data in
            DispatchQueue.main.async {
                if success, let data {
                    do {
                        let model = try JSONDecoder().decode(ListGenresResponseEntity.self, from: data)
                        self.listGenres.append(contentsOf: model.genres)
                        self.onGerDataGenresSuccess?()
                    } catch {
                        self.onGetDataFail?(.decodeError)
                    }
                } else {
                    self.onGetDataFail?(.decodeError)
                }
            }
        }
    }
}
