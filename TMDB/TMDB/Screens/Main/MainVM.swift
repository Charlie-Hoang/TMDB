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
    
    private var searching = false
    var query: String = ""
    
    init(apiService: ApiServiceProtocol) {
        self.apiService = apiService
    }
    func fetchTrendingMovie(firstPage: Bool = true){
        searching = false
        currentPage = firstPage ? 1 : (currentPage + 1)
        print("page: \(currentPage)")
        apiService.fetchTrendingMovies(time_window: .day, page: currentPage, completion: { [weak self] result in
            
            switch result{
            case .success(let res):
                
                if let _movies = res.results{
                    self?.processMovies(movies: _movies)
                }
                
                self?.callback_reloadCollectionView?()
            case .failure(_):
                print("error")
                self?.callback_reloadCollectionView?()
            }
        })
    }
    func fetchSearchingMovie(query: String, firstPage: Bool = true){
        searching = true
        currentPage = firstPage ? 1 : (currentPage + 1)
        self.query = query
        apiService.searchMovies(query: query, page: currentPage, completion: { [weak self] result in
            switch result{
            case .success(let res):
                if let _movies = res.results{
                    self?.processMovies(movies: _movies)
                }
                self?.callback_reloadCollectionView?()
            case .failure(_):
                print("error")
                self?.callback_reloadCollectionView?()
            }
        })
    }
    func fetchNextPage(){
        if searching{
            fetchSearchingMovie(query: query, firstPage: false)
        }else{
            fetchTrendingMovie(firstPage: false)
        }
    }
    func processMovies(movies: [Movie]){
        if currentPage == 1{
            self.movies.removeAll()
            self.cellVMs.removeAll()
        }
        self.movies.append(contentsOf: movies)
        self.cellVMs.append(contentsOf: movies.map{createCellVM(movie: $0)})
    }
    func createCellVM(movie: Movie) -> MainCellVM{
        var cellVM = MainCellVM()
        
        cellVM.movie_id = movie.id
        cellVM.poster = movie.posterPathURL(width: TMDB_poster_width)
        cellVM.title = movie.title
        cellVM.year = movie.releaseYear()
        cellVM.rate = movie.rateString()
        return cellVM
    }
}

