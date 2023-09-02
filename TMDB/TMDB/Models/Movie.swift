//
//  Movie.swift
//  TMDB
//
//  Created by Charlie on 30/8/23.
//

import Foundation

struct Movies: Codable{
    var page: Int?
    var results: [Movie]?
    var total_pages: Int?
    var total_results: Int?
}

struct Movie: Codable{
    var adult: Bool?
    var backdrop_path: String?
    var id: UInt?
    var title: String?
//    var original_language: String?
//    var original_title: String?
    var overview: String?
    var poster_path: String?
//    var media_type: String?
//    var genre_ids: [Int]?
//    var popularity: Float?
    var release_date: String?
//    var video: Bool?
    var vote_average: Float?
    var vote_count: Float?
    
    func posterPathURL(width: Int) -> URL?{
        return  URL(string: URL_image + String(width) + (poster_path ?? ""))
    }
    func backdropPathURL(width: Int) -> URL?{
        return  URL(string: URL_image + String(width) + (backdrop_path ?? ""))
    }
    func rateString() -> String{
        return String(format: "%.1f", vote_average ?? 0)
    }
    func releaseYear() -> String?{
        return release_date?.components(separatedBy: "-")[0]
    }
}
