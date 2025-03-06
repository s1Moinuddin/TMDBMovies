//
//  APIEndpoints.swift
//  APIClient_AF5
//
//  Created by S.M.Moinuddin on 5/14/20.
//  Copyright © 2020 S.M.Moinuddin. All rights reserved.
//

import Foundation
import Alamofire


//MARK:- Login
enum LoginEndPoint: Endpoint {
    
    case Credentials(email:String, password:String)
    case httpbin
    
    var method: HTTPMethod {
        switch self {
        case .Credentials:
            return .post
        case .httpbin:
            return .get
        }
    }
    
    var path: String {
        switch self {
        case .Credentials:
            return KBasePath + OauthPath.signin.rawValue
        case .httpbin:
            return KBasePath + OauthPath.dummy.rawValue
        }
    }
    
    var query: [String: Any]  {
        switch self {
        case .Credentials(let email, let pass):
            return ["user_login[email]": email, "user_login[password]": pass]
        case .httpbin:
            return [String: Any]()
        }
    }
}

//MARK:- Movie
enum MovieEndPoint: Endpoint {
    
    case categories
    case movieWithCategory(categoryId:Int, page:Int)
    case popularMovieswithCategory(categoryId:Int, page:Int)
    
    var method: HTTPMethod {
        switch self {
        case .categories:
            return .get
        case .movieWithCategory:
            return .get
        case .popularMovieswithCategory:
            return .get
        }
    }
    
    var path: String {
        switch self {
        case .categories:
            return KBasePath + OauthPath.catrgories.rawValue
        case .movieWithCategory:
            return KBasePath + OauthPath.movieByCatrgory.rawValue
        case .popularMovieswithCategory:
            return KBasePath + OauthPath.popularMovie.rawValue
        }
    }
    
    var query: [String: Any]  {
        switch self {
        case .categories:
            return [String: Any]()
        case .movieWithCategory(let categoryID, let page):
            return ["with_genres": categoryID, "page": page,
                    "include_adult": false, "include_video": false, "sort_by": "popularity.desc"]
        case .popularMovieswithCategory(let categoryID, let page):
            return ["with_genres": categoryID, "page": page]
        }
    }
}
