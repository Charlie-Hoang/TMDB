//
//  ApiService.swift
//  TMDB
//
//  Created by Charlie on 30/8/23.
//

import Foundation

//Protocol
protocol ApiServiceProtocol{
    func fetchTrendingMovies(time_window: MovieTrendingTimeWindow, page: Int, completion: @escaping(Result<Movies, Error>) -> Void)
    func searchMovies(query: String, page: Int, completion: @escaping(Result<Movies, Error>) -> Void)
    func fetchMovieDetails(movie_id: UInt, completion: @escaping(Result<Movie, Error>) -> Void)
}

//ApiService class
public final class ApiService: ApiServiceProtocol{
    private var baseURLString: String
    
    init(baseURLString: String){
        self.baseURLString = baseURLString
    }
    func fetchTrendingMovies(time_window: MovieTrendingTimeWindow = .day, page: Int = 1, completion: @escaping(Result<Movies, Error>) -> Void){
        guard let request = makeRequest(endpoint: .getTrendingMovies(time_window: time_window, page: page)) else {
            completion(Result.failure(ApiError.unidentified))
            return
        }
        excuteRequest(request: request, completion: completion)
    }
    func searchMovies(query: String, page: Int = 1, completion: @escaping(Result<Movies, Error>) -> Void){
        guard let request = makeRequest(endpoint: .searchMovies(query: query, include_adult: false, page: page)) else {
            completion(Result.failure(ApiError.unidentified))
            return
        }
        excuteRequest(request: request, completion: completion)
    }
    func fetchMovieDetails(movie_id: UInt, completion: @escaping(Result<Movie, Error>) -> Void){
        guard let request = makeRequest(endpoint: .getMovieDetails(movie_id: movie_id)) else {
            completion(Result.failure(ApiError.unidentified))
            return
        }
        excuteRequest(request: request, completion: completion)
    }
}

//Private
extension ApiService{
    private func makeRequest(endpoint: Endpoint) -> URLRequest?{
        guard let url = URL(string: baseURLString + endpoint.path()) else {return nil}
        var request = URLRequest(url: url)
        if endpoint.isCacheEnable(){
            request.cachePolicy = Reachability.isConnectedToNetwork() ? .reloadIgnoringLocalCacheData : .returnCacheDataDontLoad
        }else{
            request.cachePolicy = .reloadIgnoringLocalCacheData
        }
        request.httpMethod = endpoint.method()
        return request
    }
    private func excuteRequest<T: Decodable>(request: URLRequest, completion: @escaping(Result<T, Error>) -> Void){
        let task = URLSession.shared.dataTask(with: request) { data, responseHeader, error in
            guard let data = data else {
                completion(Result.failure(ApiError.unidentified))
                return
            }
            do{
                let responseModel = try JSONDecoder().decode(T.self, from: data)
                completion(Result.success(responseModel))
            }catch{
                completion(Result.failure(ApiError.unidentified))
            }
        }
        task.resume()
    }
}
