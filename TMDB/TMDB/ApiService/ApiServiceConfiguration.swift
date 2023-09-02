//
//  ApiServiceConfiguration.swift
//  TMDB
//
//  Created by Charlie on 2/9/23.
//

import Foundation

protocol ApiServiceConfigurable{
    var apiKey: String {get}
    var baseURLString: String? {get set}
    var language: String? {get set}
    var posterWidth: UInt? {get set}
    var backdropWidth: UInt? {get set}
    var path_trending_movies: String? {get set}
    var path_search_movies: String? {get set}
    var path_movie_details: String? {get set}
}

struct ApiServiceConfiguration: ApiServiceConfigurable{
    var apiKey: String
    var baseURLString: String?
    var language: String?
    var posterWidth: UInt?
    var backdropWidth: UInt?
    var path_trending_movies: String?
    var path_search_movies: String?
    var path_movie_details: String?
    init(apiKey: String, baseURLString: String? = URL_base,
         language: String? = "en-US",
         posterWidth: UInt? = 200,
         backdropWidth: UInt? = 300,
         path_trending_movies: String? = URL_path_trending_movies,
         path_search_movies: String? = URL_path_search_movie,
         path_movie_details: String? = URL_path_movie_detail
    ) {
        self.apiKey = apiKey
        self.baseURLString = baseURLString
        self.language = language
        self.posterWidth = posterWidth
        self.backdropWidth = backdropWidth
        self.path_trending_movies = path_trending_movies
        self.path_search_movies = path_search_movies
        self.path_movie_details = path_movie_details
    }
}
