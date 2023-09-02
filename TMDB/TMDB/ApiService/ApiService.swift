//
//  ApiService.swift
//  TMDB
//
//  Created by Charlie on 30/8/23.
//

import Foundation

//Protocol
protocol ApiServiceProtocol{
    var config: ApiServiceConfigurable {get}
    func fetchTrendingMovies(time_window: MovieTrendingTimeWindow, page: Int, completion: @escaping(Result<Movies, Error>) -> Void)
    func searchMovies(query: String, page: Int, completion: @escaping(Result<Movies, Error>) -> Void)
    func fetchMovieDetails(movie_id: UInt, completion: @escaping(Result<Movie, Error>) -> Void)
}

//ApiService class
public final class ApiService: ApiServiceProtocol{
    var config: ApiServiceConfigurable
    
    init(config: ApiServiceConfigurable){
        self.config = config
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
        guard let url = endpoint.buildRequestURL(config: config) else {return nil}
        print("request: \(url.absoluteString)")
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
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                print("Network error:", error.localizedDescription)
                completion(Result.failure(ApiError.networkError))
                return
            }
            
            if let httpResponse = response as? HTTPURLResponse {
                guard let data = data else {
                    print("request failed")
                    completion(Result.failure(ApiError.invalidResponse))
                    return
                }
                switch httpResponse.statusCode {
                case 200..<300:
                    // Successful response; parse the data here
                    do{
                        let responseModel = try JSONDecoder().decode(T.self, from: data)
                        print("request success")
                        completion(Result.success(responseModel))
                    }catch{
                        print("request failed")
                        completion(Result.failure(ApiError.invalidResponse))
                    }
                case 400...499:
                    // Client error
                    do{
                        let errorResponse = try JSONDecoder().decode(ResponseError.self, from: data)
                        print("Client error:", errorResponse.status_message)
                        completion(Result.failure(ApiError.responseError(error: errorResponse)))
                    }catch{
                        print("request failed")
                        completion(Result.failure(ApiError.invalidResponse))
                    }
                case 500...599:
                    // Server error; handle as needed
                    print("Server error:", httpResponse.statusCode)
                    completion(Result.failure(ApiError.serverError))
                default:
                    // Handle other status codes if necessary
                    print("Unexpected status code:", httpResponse.statusCode)
                    completion(Result.failure(ApiError.unidentified))
                }
            }
            
            
        }
        task.resume()
    }
}
