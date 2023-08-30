//
//  ApiUtilities.swift
//  TMDB
//
//  Created by Charlie on 30/8/23.
//

import Foundation

enum Endpoint{
    case getTrendingMovies(time_window: MovieTrendingTimeWindow, page: Int, language: String)
    case searchMovies(query: String, include_adult: Bool, page: Int, language: String)
    case getMovieDetails(movie_id: UInt, language: String)
    
    func path() -> String{
        var param = ["api_key": TMDB_ApiKey] as [String: String]
        switch self {
        case .getTrendingMovies(let time_window, let page, let language):
            param["page"] = "\(page)"
            param["language"] = language
            return URL_path_trending_movies + "/\(time_window.rawValue)" + param.buildQueryString()
        case .searchMovies(let query, let include_adult, let page, let language):
            param["query"] = query
            param["include_adult"] = String(include_adult)
            param["page"] = "\(page)"
            param["language"] = language
            return URL_path_search_movie + param.buildQueryString()
        case .getMovieDetails(let movie_id, let language):
            param["language"] = language
            return URL_path_movie_detail + "/\(movie_id)" + param.buildQueryString()
        }
    }
    func method() -> String{
        switch self {
        case .getTrendingMovies, .searchMovies, .getMovieDetails:
            return "GET"
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
