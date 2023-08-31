//
//  DetailVM.swift
//  TMDB
//
//  Created by Charlie on 31/8/23.
//

import Foundation

class DetailVM{
    var apiService: ApiServiceProtocol!
    var movie: Movie?
    var movie_id: UInt?
    var callback_reloadView: RESPONSE_EMPTY?
    
    var title: String?
    var backdropURL: URL?
    var year: String?
    var overview: String?
    var rate: String?
    
    
    init(apiService: ApiServiceProtocol, movie_id: UInt) {
        self.apiService = apiService
        self.movie_id = movie_id
    }
    
    func fetchDetail(){
        apiService.fetchMovieDetails(movie_id: movie_id ?? 0, completion: { [weak self] result in
            
            switch result{
            case .success(let res):
                
                self?.processMovieDetail(movie: res)
                
                self?.callback_reloadView?()
            case .failure(_):
                print("error")
                self?.callback_reloadView?()
            }
        })
    }
    
    func processMovieDetail(movie: Movie){
        title = movie.title
        backdropURL = movie.backdropPathURL(width: TMDB_backdrop_width)
        year = movie.releaseYear()
        overview = movie.overview
        rate = movie.rateString()
    }
    
    
}
