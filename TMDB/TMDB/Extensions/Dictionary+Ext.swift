//
//  Dictionary+Ext.swift
//  TMDB
//
//  Created by Charlie on 30/8/23.
//

import Foundation

extension Dictionary{
    func buildQueryString() -> String {
        guard let self = self as? [String: String] else {return ""}
        var urlVars:[String] = []
        
        for (k, value) in self {
            let value = value as NSString
            if let encodedValue = value.addingPercentEncoding(withAllowedCharacters: NSCharacterSet.urlQueryAllowed) {
                urlVars.append(k + "=" + encodedValue)
            }
        }

        return urlVars.isEmpty ? "" : "?" + urlVars.joined(separator: "&")
    }
}
