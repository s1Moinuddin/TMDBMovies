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
        case title = "title"
        case imagePath = "poster_path"
    }

    var description: String {
        "Movie(title: \(title), imagePath: \(imagePath))"
    }
}

struct MovieResponse: Decodable {
    let movies: [Movie]
    let page: Int
    let totalPages: Int
    
    enum CodingKeys: String, NestableCodingKey {
        case movies = "results"
        case page
        case totalPages = "total_pages"
    }
}
