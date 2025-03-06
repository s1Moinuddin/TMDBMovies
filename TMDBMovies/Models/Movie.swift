//
//  Movie.swift
//  TMDBMovies
//
//  Created by S.M.Moinuddin on 6/3/25.
//

import Foundation

struct Movie: Decodable, CustomStringConvertible {
    var id: Int
    var title: String
    var imagePath: String

    enum CodingKeys: String, NestableCodingKey {
        case id
        case title = "original_title"
        case imagePath = "poster_path"
    }

    var description: String {
        "Movie(title: \(title), imagePath: \(imagePath))"
    }
}
