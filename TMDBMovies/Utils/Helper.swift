//
//  Helper.swift
//  TMDBMovies
//
//  Created by S.M.Moinuddin on 6/3/25.
//

import Foundation

class Helper {
    static func getImageURL(path: String?) -> URL? {
        guard let path = path else {
            return nil
        }
        return URL(string: "https://image.tmdb.org/t/p/w500\(path)")
    }
}
