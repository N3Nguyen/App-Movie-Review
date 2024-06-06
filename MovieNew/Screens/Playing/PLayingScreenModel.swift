//
//  PLayingScreenModel.swift
//  MovieNew
//
//  Created by QuocTN on 26/12/2023.
//

import Foundation
import UIKit
class PLayingScreenModel: NSObject {
    var listMoviesNowPlaying: ListMovies?
    var listMoviesDiscover: ListMovies?
    
    var onGetDataFail: ((_ error: NetworkServiceError) -> Void)?
    var onGetDataSuccess: (() -> Void)?
    
    func getMoviesNowPlaying(onSucess: @escaping() -> Void, onFail: @escaping() -> Void) {
        let detailMovieURL: String = "\(ServerConstants.baseURL)\(ServerConstants.moviePath)\(Contants.nowPlayingType)"
        let params = [ListMovieRequestEntity.apiKey : ServerConstants.apiKey]
        APIHelpers.shared.requestGET(url: detailMovieURL, params: params) { success, data in
            DispatchQueue.main.async {
                if success {
                    do {
                        let model = try JSONDecoder().decode(ListMovies.self, from: data!)
                        self.listMoviesNowPlaying = model
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
    
    func getMoviesDisCover(onSucess: @escaping() -> Void, onFail: @escaping() -> Void) {
        let detailMovieURL: String = "\(ServerConstants.baseURL)/\(Contants.discoverType)/movie"
        let params = [ListMovieRequestEntity.apiKey : ServerConstants.apiKey]
        APIHelpers.shared.requestGET(url: detailMovieURL, params: params) { success, data in
            DispatchQueue.main.async {
                if success {
                    do {
                        let model = try JSONDecoder().decode(ListMovies.self, from: data!)
                        self.listMoviesDiscover = model
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
    
    func requestMainData() {
        let dispatchGroup: DispatchGroup = DispatchGroup()
        var onGetDataFail: NetworkServiceError?
        
        dispatchGroup.enter()
        self.getMoviesNowPlaying {
            dispatchGroup.leave()
        } onFail: {
            onGetDataFail = .decodeError
            dispatchGroup.leave()
        }
        
        dispatchGroup.enter()
        self.getMoviesDisCover() {
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
