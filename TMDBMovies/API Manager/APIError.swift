//
//  APIError.swift
//  APIClient_AF5
//
//  Created by S.M.Moinuddin on 5/14/20.
//  Copyright © 2020 S.M.Moinuddin. All rights reserved.
//

import Foundation


enum APIError: Int {
    case unauthorized   = 401
    case notFound       = 404
    case timeOut        = 408
    case preconditioned = 412
    case invalidParam   = 422
    case dependencyFail = 424
    case serverProblem  = 500
}
