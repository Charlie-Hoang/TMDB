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
    
    func path() -> String{
        var param = ["api_key": TMDB_ApiKey, "language": TMDB_Language] as [String: String]
        switch self {
        case .getTrendingMovies(let time_window, let page):
            param["page"] = "\(page)"
            return URL_path_trending_movies + "/\(time_window.rawValue)" + param.buildQueryString()
        case .searchMovies(let query, let include_adult, let page):
            param["query"] = query
            param["include_adult"] = String(include_adult)
            param["page"] = "\(page)"
            return URL_path_search_movie + param.buildQueryString()
        case .getMovieDetails(let movie_id):
            return URL_path_movie_detail + "/\(movie_id)" + param.buildQueryString()
        }
    }
    func method() -> String{
        switch self {
        case .getTrendingMovies, .searchMovies, .getMovieDetails:
            return "GET"
        }
    }
    func enableCache() -> Bool{
        switch self{
        case .getTrendingMovies, .getMovieDetails: return true
        case.searchMovies: return false
        }
    }
}

enum ApiError: Error{
    case unidentified
}

enum MovieTrendingTimeWindow: String {
    case day
    case week
}

