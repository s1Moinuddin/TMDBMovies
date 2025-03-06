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
let KBasePath = "https://api.themoviedb.org/3"
#endif

enum OauthPath: String {
    
    case signin                     = "/api/v1/sign-in"
    case dummy                      = "/get"
    case catrgories                 = "/genre/movie/list"
    case movieByCatrgory            = "/discover/movie"
    case popularMovie               = "/movie/popular"

    
}

let accessToken = "eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiJmN2EyMGIyNzM5MTBjZTM0MDE1NGNkZDk5Y2YyNjEwYiIsIm5iZiI6MTc0MTI0MDg5My4wMDg5OTk4LCJzdWIiOiI2N2M5M2EzZGVmOWE5MGNkYmEyNDlkOTciLCJzY29wZXMiOlsiYXBpX3JlYWQiXSwidmVyc2lvbiI6MX0.voV8KdtJ25AQDtiBds9FGcAsUQDuJpazIso5zO5veQY"
