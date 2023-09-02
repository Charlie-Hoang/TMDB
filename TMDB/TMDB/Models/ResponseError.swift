//
//  ResponseError.swift
//  TMDB
//
//  Created by Charlie on 2/9/23.
//

import Foundation

struct ResponseError: Decodable{
    var status_code: UInt?
    var status_message: String?
    var success: Bool?
}
