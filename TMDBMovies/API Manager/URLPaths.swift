//
//  URLPaths.swift
//  APIClient_AF5
//
//  Created by S.M.Moinuddin on 5/14/20.
//  Copyright © 2020 S.M.Moinuddin. All rights reserved.
//

import Foundation


#if DEVELOPMENT
let KBasePath = "https://httpbin.org"
#else
let KBasePath = "https://httpbin.org"
#endif

enum OauthPath: String {
    
    case signin                     = "/api/v1/sign-in"
    case dummy                      = "/get"
    
}
