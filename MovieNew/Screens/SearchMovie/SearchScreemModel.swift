//
//  SearchScreemModel.swift
//  MovieNew
//
//  Created by QuocTN on 30/12/2023.
//

import Foundation
import UIKit
class SearchScreenModel: NSObject {
    // MARK: Model default closure, remove if unused
    var listTrendingData: ListMovies?
    var listSearchMovies: ListMovies?
    var listGenresData: ListGenresResponseEntity?
    
    var onGetDataFail: ((_ error: NetworkServiceError) -> Void)?
    var onGetDataSuccess: (() -> Void)?
    
    func getSearchTrendingMovie(onSucess: @escaping() -> Void, onFail: @escaping() -> Void) {
        let searchMovieURL: String = "\(ServerConstants.baseURL)\(ServerConstants.trendingList)"
        let params = [DetailRequestEntity.apiKey : ServerConstants.apiKey]
        APIHelpers.shared.requestGET(url: searchMovieURL, params: params) { success, data in
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
    
    func getSearchMovies(titleMovie: String, onSucess: @escaping() -> Void, onFail: @escaping() -> Void) {
        let searchMovieURL: String = "\(ServerConstants.baseURL)\(ServerConstants.searchList)"
        let params = [DetailRequestEntity.apiKey : ServerConstants.apiKey, DetailRequestEntity.query : "\(titleMovie)"]
        
        APIHelpers.shared.requestGET(url: searchMovieURL, params: params) { success, data in
            DispatchQueue.main.async {
                if success {
                    do {
                        let model = try JSONDecoder().decode(ListMovies.self, from: data!)
                        self.listSearchMovies = model
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
    
    func getDataGenres(onSucess: @escaping() -> Void, onFail: @escaping() -> Void) {
        let genreslMovieURL: String = "\(ServerConstants.baseURL)\(ServerConstants.genresList)"
        let params = [DetailRequestEntity.apiKey : ServerConstants.apiKey]
        APIHelpers.shared.requestGET(url: genreslMovieURL, params: params) { success, data in
            DispatchQueue.main.async {
                if success, let data {
                    do {
                        let model = try JSONDecoder().decode(ListGenresResponseEntity.self, from: data)
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
    
    func requestMainData(titleSearch: String){
        let dispatchGroup: DispatchGroup = DispatchGroup()
        var onGetDataFail: NetworkServiceError?
        
        dispatchGroup.enter()
        self.getSearchTrendingMovie {
            dispatchGroup.leave()
        } onFail: {
            onGetDataFail = .decodeError
            dispatchGroup.leave()
        }
        
        dispatchGroup.enter()
        self.getSearchMovies(titleMovie: titleSearch) {
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
    
    func requestGenresData(){
        let dispatchGroup: DispatchGroup = DispatchGroup()
        var onGetDataFail: NetworkServiceError?
        
        dispatchGroup.enter()
        self.getDataGenres {
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
