//
//  ApiUtilities.swift
//  TMDB
//
//  Created by Charlie on 30/8/23.
//

import Foundation

enum Endpoint{
    case getTrendingMovies(time_window: MovieTrendingTimeWindow, page: Int)
    case searchMovies(query: String, include_adult: Bool, page: Int)
    case getMovieDetails(movie_id: UInt)
    
    func baseURL(_ config: ApiServiceConfigurable) -> String {
        return config.baseURLString.orEmpty()
    }
    
    func path(_ config: ApiServiceConfigurable) -> String {
        switch self {
        case .getTrendingMovies(let time_window, _):
            return config.path_trending_movies.orEmpty() + "/\(time_window.rawValue)"
        case .searchMovies:
            return config.path_search_movies.orEmpty()
        case .getMovieDetails(let movie_id):
            return config.path_movie_details.orEmpty() + "/\(movie_id)"
        }
    }
    
    func params(_ config: ApiServiceConfigurable) -> String{
        var _params = ["api_key": config.apiKey, "language": config.language.orEmpty()] as [String: String]
        switch self {
        case .getTrendingMovies(_, let page):
            _params["page"] = "\(page)"
        case .searchMovies(let query, let include_adult, let page):
            _params["query"] = query
            _params["include_adult"] = String(include_adult)
            _params["page"] = "\(page)"
        case .getMovieDetails:
            break
        }
        return _params.buildQueryString()
    }
    
    func method() -> String{
        switch self {
        case .getTrendingMovies, .searchMovies, .getMovieDetails:
            return "GET"
        }
    }
    
    func buildRequestURL(config: ApiServiceConfigurable) -> URL?{
        return URL(string: baseURL(config) + path(config) + params(config))
    }
    
    func isCacheEnable() -> Bool{
        return true
    }
}

enum ApiError: Error{
    case unidentified
    case networkError
    case invalidResponse
    case responseError(error: ResponseError)
    case serverError
}

enum MovieTrendingTimeWindow: String {
    case day
    case week
}

