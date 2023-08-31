//
//  MainVM.swift
//  TMDB
//
//  Created by Charlie on 31/8/23.
//

import Foundation

class MainVM{
    var apiService: ApiServiceProtocol!
    var movies = [Movie]()
    var cellVMs = [MainCellVM]()
    
    var callback_reloadCollectionView: RESPONSE_EMPTY?
    var currentPage = 1
    
    init(apiService: ApiServiceProtocol) {
        self.apiService = apiService
    }
    func fetchFirstPage(){
        currentPage = 1
        apiService.fetchTrendingMovies(time_window: .day, page: 1, completion: { [weak self] result in
            
            switch result{
            case .success(let res):
                
                if let _movies = res.results{
                    self?.processReloadMovies(movies: _movies)
                    
                }
                
                self?.callback_reloadCollectionView?()
            case .failure(_):
                print("error")
                self?.callback_reloadCollectionView?()
            }
        })
    }
    func fetchNextPage(){
        currentPage += 1
        apiService.fetchTrendingMovies(time_window: .day, page: currentPage, completion: { [weak self] result in
            switch result{
            case .success(let res):
                if let _movies = res.results{
                    self?.processAppendMovies(movies: _movies)
                }
                self?.callback_reloadCollectionView?()
            case .failure(_):
                print("error")
                self?.callback_reloadCollectionView?()
            }
        })
    }
    func processReloadMovies(movies: [Movie]){
        self.movies = movies
        cellVMs.removeAll()
        cellVMs.append(contentsOf: movies.map{createCellVM(movie: $0)})
    }
    func processAppendMovies(movies: [Movie]){
        self.movies.append(contentsOf: movies)
        cellVMs.append(contentsOf: movies.map{createCellVM(movie: $0)})
    }
    func createCellVM(movie: Movie) -> MainCellVM{
        var cellVM = MainCellVM()
        
        cellVM.movie_id = movie.id
        cellVM.poster = movie.posterPathURL(width: TMDB_poster_width)
        cellVM.title = movie.title
        cellVM.year = movie.releaseYear()
        cellVM.rate = movie.rateString()
        print("cellVM: \(cellVM)")
        return cellVM
    }
}

