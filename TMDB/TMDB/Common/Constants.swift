//
//  Constants.swift
//  TMDB
//
//  Created by Charlie on 30/8/23.
//



let TMDB_ApiKey = "47aa75b56464da7a186b813a50035cd4"
let TMDB_Language = "en-US"
let TMDB_poster_width = 200
let TMDB_backdrop_width = 300

let URL_base = "https://api.themoviedb.org/3"
let URL_path_trending_movies = "/trending/movie"
let URL_path_search_movie = "/search/movie"
let URL_path_movie_detail = "/movie"
let URL_image = "https://image.tmdb.org/t/p/w"


typealias RESPONSE_COMLETE = (Bool) -> Void
typealias RESPONSE_EMPTY = () -> Void
typealias RESPONSE_TYPE<T> = (T) -> Void
