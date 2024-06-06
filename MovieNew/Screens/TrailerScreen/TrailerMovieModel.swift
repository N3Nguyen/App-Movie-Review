import Foundation
import UIKit
class TrailerMovieModel: NSObject {
    var listLinkTrailerMovie: ListTitleTrailer?
    
    var onGetDataFail: ((_ error: NetworkServiceError) -> Void)?
    var onGetDataSuccess: (() -> Void)?
    
    func getLinkTrailerMovie(movieID: Int, onSucess: @escaping() -> Void, onFail: @escaping() -> Void) {
        let trailerMovieURL: String = "\(ServerConstants.baseURL)\(ServerConstants.moviePath)\(movieID)/videos"
        let params = [DetailRequestEntity.apiKey : ServerConstants.apiKey]
        APIHelpers.shared.requestGET(url: trailerMovieURL, params: params) { success, data in
            DispatchQueue.main.async {
                if success {
                    do {
                        let model = try JSONDecoder().decode(ListTitleTrailer.self, from: data!)
                        self.listLinkTrailerMovie = model
                        onSucess()
                    } catch {
                        onFail()
                    }
                } else {
                    onFail()
                }
            }
        }
    }
    
    func requestMainData(movieID: Int){
        let dispatchGroup: DispatchGroup = DispatchGroup()
        var onGetDataFail: NetworkServiceError?
        
        dispatchGroup.enter()
        self.getLinkTrailerMovie(movieID: movieID) {
            dispatchGroup.leave()
        } onFail: {
            onGetDataFail = .decodeError
            dispatchGroup.leave()
        }
        
        dispatchGroup.notify(queue: .main) {
            self.onGetDataSuccess?()
            
            let appError = onGetDataFail
            if let error = appError {
                self.onGetDataFail?(error)
            }
        }
    }
}
