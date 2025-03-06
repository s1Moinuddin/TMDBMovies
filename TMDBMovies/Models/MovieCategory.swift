//
//  MovieCategory.swift
//  TMDBMovies
//
//  Created by S.M.Moinuddin on 6/3/25.
//

struct MovieCategory: Decodable {
    let id: Int
    let name: String
}

struct MovieCategoryResponse: Decodable {
    let categories: [MovieCategory]
    
    enum CodingKeys: String, NestableCodingKey {
        case categories = "genres"
    }
}
