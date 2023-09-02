//
//  String+Ext.swift
//  TMDB
//
//  Created by Charlie on 2/9/23.
//

import Foundation

extension String?{
    func orEmpty() -> String{
        if let self = self{
            return self
        }
        return ""
    }
}
