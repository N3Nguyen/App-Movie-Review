//
//  DetailMovieModel.swift
//  MovieNew
//
//  Created by QuocTN on 18/12/2023.
//

import Foundation
import UIKit
class DetailMovieModel: NSObject {
    var listMovieDetailEntity: ListMovieDetailEntity?
    var listCategory: ListCategoryResponseEntity?
    var listSimilarMovies: [MovieEntity]?
    var listReviewsMovie: ListTitleReview?
    
    var onGetDataFail: ((_ error: NetworkServiceError) -> Void)?
    var onGetDataSuccess: (() -> Void)?
    
    func getDetailMovie(movieID: Int, onSucess: @escaping() -> Void, onFail: @escaping() -> Void) {
        let detailMovieURL: String = "\(ServerConstants.baseURL)\(ServerConstants.moviePath)\(movieID)"
        let params = [DetailRequestEntity.apiKey : ServerConstants.apiKey]
        APIHelpers.shared.requestGET(url: detailMovieURL, params: params) { success, data in
            DispatchQueue.main.async {
                if success {
                    do {
                        let model = try JSONDecoder().decode(ListMovieDetailEntity.self, from: data!)
                        self.listMovieDetailEntity = model
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
    
    func getDetailListCategory(movieID: Int, onSucess: @escaping() -> Void, onFail: @escaping() -> Void) {
        let detailMovieURL: String = "\(ServerConstants.baseURL)\(ServerConstants.moviePath)\(movieID)/credits"
        let params = [DetailRequestEntity.apiKey : ServerConstants.apiKey]
        APIHelpers.shared.requestGET(url: detailMovieURL, params: params) { success, data in
            DispatchQueue.main.async {
                if success {
                    do {
                        let model = try JSONDecoder().decode(ListCategoryResponseEntity.self, from: data!)
                        self.listCategory = model
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
    
    func getSimilarMovies(movieID: Int, onSucess: @escaping() -> Void, onFail: @escaping() -> Void) {
        let detailMovieURL: String = "\(ServerConstants.baseURL)\(ServerConstants.moviePath)\(movieID)/similar"
        let params = [DetailRequestEntity.apiKey : ServerConstants.apiKey]
        APIHelpers.shared.requestGET(url: detailMovieURL, params: params) { success, data in
            DispatchQueue.main.async {
                if success {
                    do {
                        let model = try JSONDecoder().decode(ListMovies.self, from: data!)
                        self.listSimilarMovies = model.results
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
    
    func getReviewsMovie(movieID: Int, onSucess: @escaping() -> Void, onFail: @escaping() -> Void) {
        let reviewsMovieURL: String = "\(ServerConstants.baseURL)\(ServerConstants.moviePath)\(movieID)/reviews"
        let params = [DetailRequestEntity.apiKey : ServerConstants.apiKey]
        APIHelpers.shared.requestGET(url: reviewsMovieURL, params: params) { success, data in
            DispatchQueue.main.async {
                if success {
                    do {
                        let model = try JSONDecoder().decode(ListTitleReview.self, from: data!)
                        self.listReviewsMovie = model
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
    
    func requestMainData(movieID: Int) {
        let dispatchGroup: DispatchGroup = DispatchGroup()
        var onGetDataFail: NetworkServiceError?
        
        dispatchGroup.enter()
        self.getDetailMovie(movieID: movieID) {
            dispatchGroup.leave()
        } onFail: {
            onGetDataFail = .decodeError
            dispatchGroup.leave()
        }
        
        dispatchGroup.enter()
        self.getDetailListCategory(movieID: movieID) {
            dispatchGroup.leave()
        } onFail: {
            onGetDataFail = .decodeError
            dispatchGroup.leave()
        }
        
        dispatchGroup.enter()
        self.getSimilarMovies(movieID: movieID) {
            dispatchGroup.leave()
        } onFail: {
            onGetDataFail = .decodeError
            dispatchGroup.leave()
        }
        
        dispatchGroup.notify(queue: .main) {
            self.onGetDataSuccess?()
            
            var appError = onGetDataFail
            if let error = appError {
                self.onGetDataFail?(error)
            }
        }
    }
    
    func requestMainDataReview(movieID: Int) {
        let dispatchGroup: DispatchGroup = DispatchGroup()
        var onGetDataFail: NetworkServiceError?
        
        dispatchGroup.enter()
        self.getReviewsMovie(movieID: movieID) {
            dispatchGroup.leave()
        } onFail: {
            onGetDataFail = .decodeError
            dispatchGroup.leave()
        }
        
        dispatchGroup.notify(queue: .main) {
            self.onGetDataSuccess?()
            
            var appError = onGetDataFail
            if let error = appError {
                self.onGetDataFail?(error)
            }
        }
    }
}
