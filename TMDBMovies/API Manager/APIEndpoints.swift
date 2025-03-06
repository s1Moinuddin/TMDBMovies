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
