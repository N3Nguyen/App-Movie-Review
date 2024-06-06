//
//  HomeScreenModel.swift
//  MovieNew
//
//  Created by QuocTN on 03/12/2023.
//

import Foundation
import UIKit
class HomeScreenModel: NSObject {
    // MARK: Model default closure, remove if unused
    var listTrendingData: ListMovies?
    var listCommingSoonData: ListMovies?
    var listGenresData: ListGenresResponseEntity?
    
    var onGetDataFail: ((_ error: NetworkServiceError) -> Void)?
    var onGetDataSuccess: (() -> Void)?
    
    func getHomeTrendingMovie(onSucess: @escaping() -> Void, onFail: @escaping() -> Void) {
        let homeMovieURL: String = "\(ServerConstants.baseURL)\(ServerConstants.trendingList)"
        let params = [DetailRequestEntity.apiKey : ServerConstants.apiKey]
        APIHelpers.shared.requestGET(url: homeMovieURL, params: params) { success, data in
            DispatchQueue.main.async {
                if success {
                    do {
                        let model = try JSONDecoder().decode(ListMovies.self, from: data!)
                        self.listTrendingData = model
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
    
    func getHomeCommingSoonMovie(onSucess: @escaping() -> Void, onFail: @escaping() -> Void) {
        let homeMovieURL: String = "\(ServerConstants.baseURL)\(ServerConstants.commingSoonList)"
        let params = [DetailRequestEntity.apiKey : ServerConstants.apiKey]
        APIHelpers.shared.requestGET(url: homeMovieURL, params: params) { success, data in
            DispatchQueue.main.async {
                if success {
                    do {
                        let model = try JSONDecoder().decode(ListMovies.self, from: data!)
                        self.listCommingSoonData = model
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
    
    func getListGenres(onSucess: @escaping() -> Void, onFail: @escaping() -> Void) {
        let genresMovieURL: String = "\(ServerConstants.baseURL)\(ServerConstants.genresList)"
        let params = [DetailRequestEntity.apiKey : ServerConstants.apiKey]
        APIHelpers.shared.requestGET(url: genresMovieURL, params: params) { success, data in
            DispatchQueue.main.async {
                if success {
                    do {
                        let model = try JSONDecoder().decode(ListGenresResponseEntity.self, from: data!)
                        self.listGenresData = model
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
    
    func requestMainData(){
        let dispatchGroup: DispatchGroup = DispatchGroup()
        var onGetDataFail: NetworkServiceError?
        
        dispatchGroup.enter()
        self.getHomeTrendingMovie {
            dispatchGroup.leave()
        } onFail: {
            onGetDataFail = .decodeError
            dispatchGroup.leave()
        }
        
        dispatchGroup.enter()
        self.getHomeCommingSoonMovie {
            dispatchGroup.leave()
        } onFail: {
            onGetDataFail = .decodeError
            dispatchGroup.leave()
        }
        
        dispatchGroup.enter()
        self.getListGenres {
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
