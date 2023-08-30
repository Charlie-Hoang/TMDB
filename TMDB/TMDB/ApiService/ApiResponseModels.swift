//
//  ApiResponseModels.swift
//  TMDB
//
//  Created by Charlie on 30/8/23.
//

import Foundation

struct Movies: Decodable{
    var page: Int?
    var results: [Movie]?
    var total_pages: Int?
    var total_results: Int?
}

struct Movie: Decodable{
    var adult: Bool?
    var backdrop_path: String?
    var id: Int?
    var title: String?
    var original_language: String?
    var original_title: String?
    var overview: String?
    var poster_path: String?
    var media_type: String?
    var genre_ids: [Int]?
    var popularity: Float?
    var release_date: String?
    var video: Bool?
    var vote_average: Float?
    var vote_count: Double?
}
