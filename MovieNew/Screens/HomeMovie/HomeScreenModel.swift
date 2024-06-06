//
//  HomeScreenModel.swift
//  MovieNew
//
//  Created by QuocTN on 03/10/2023.
//

import Foundation
import UIKit
class HomeScreenModel: NSObject {
    // MARK: Model default closure, remove if unused
    var listTrendingData: ListMovies?
    var listCommingSoonData: ListMovies?
    
    var onGetDataFail: ((_ error: NetworkServiceError) -> Void)?
    var onGetDataSuccess: (() -> Void)?
    private var trendingURL = "https://api.themoviedb.org/3/trending/all/day?api_key=2a42783543e233df8a3369e3ce9b9019&page="
    private var commingSoonURL = "https://api.themoviedb.org/3/movie/upcoming?api_key=2a42783543e233df8a3369e3ce9b9019&page="
    func getHomeTrendingMovie() {
        let homeMovieURL: String = "\(ServerConstants.baseURL)\(ServerConstants.trendingList)"
        let params = [DetailRequestEntity.apiKey : ServerConstants.apiKey]
        APIHelpers.shared.requestGET(url: homeMovieURL, params: params) { success, data in
            DispatchQueue.main.async {
                if success {
                    do {
                        let model = try JSONDecoder().decode(ListMovies.self, from: data!)
                        self.listTrendingData = model
                        self.onGetDataSuccess?()
                    } catch {
                        self.onGetDataFail?(.decodeError)
                    }
                } else {
                    self.onGetDataFail?(.decodeError)
                }
            }
        }
    }
    
    func getHomeCommingSoonMovie() {
        let homeMovieURL: String = "\(ServerConstants.baseURL)\(ServerConstants.commingSoonList)"
        let params = [DetailRequestEntity.apiKey : ServerConstants.apiKey]
        APIHelpers.shared.requestGET(url: homeMovieURL, params: params) { success, data in
            DispatchQueue.main.async {
                if success {
                    do {
                        let model = try JSONDecoder().decode(ListMovies.self, from: data!)
                        self.listCommingSoonData = model
                        self.onGetDataSuccess?()
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
