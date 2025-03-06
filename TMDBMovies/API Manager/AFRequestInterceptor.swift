//
//  AFRequestInterceptor.swift
//  APIClient_AF5
//
//  Created by S.M.Moinuddin on 5/15/20.
//  Copyright © 2020 S.M.Moinuddin. All rights reserved.
//

import Foundation
import Alamofire

final class AFRequestInterceptor: Alamofire.RequestInterceptor {
    
    private var accessToken: String
    
    // https://github.com/Alamofire/Alamofire/issues/2998
    typealias AdapterResult = Swift.Result<URLRequest, Error>
    
    init(token:String) {
        self.accessToken = token
    }
    
    func adapt(_ urlRequest: URLRequest, for session: Session, completion: @escaping (AdapterResult) -> Void) {
        
        //path where authorization header is not needed
        let signinPath = OauthPath.signin.rawValue
        
        guard let urlStr = urlRequest.url?.absoluteString,
            urlStr.hasPrefix(KBasePath),
            !urlStr.hasSuffix(signinPath)
            else {
                /// If the request does not require authentication, we can directly return it as unmodified.
                return completion(.success(urlRequest))
        }
        
        var modifiedUrlRequest = urlRequest
        /// Set the Authorization header value using the access token.
        DLog("*** Addidng access token ***")
        modifiedUrlRequest.setValue("Bearer " + accessToken, forHTTPHeaderField: "Authorization")
        
        completion(.success(modifiedUrlRequest))
    }
    
    func retry(_ request: Request, for session: Session, dueTo error: Error, completion: @escaping (RetryResult) -> Void) {
        guard let response = request.task?.response as? HTTPURLResponse, let errorCode = APIError(rawValue: response.statusCode) else {
            /// The request did not fail due to a 401 Unauthorized response.
            /// Return the original error and don't retry the request.
            return completion(.doNotRetryWithError(error))
        }
        
        switch errorCode {
        case .unauthorized:
            DLog("******** Get Access Token ********")
            return completion(.doNotRetry)
            
        case .timeOut:
            DLog("******** REQUEST TIME OUT ********")
            DLog("Retry Count = \(request.retryCount)")
            DLog("requested URL = \(String(describing: response.url))")
            if request.retryCount == 3 {
                return completion(.doNotRetry) }
            return completion(.retryWithDelay(1.0)) // retry after 1 second
        case .invalidParam:
            DLog("************ ============ ************")
            DLog("******* WRONG PARAMETER SEND TO API *******")
            completion(.doNotRetry)
        case .notFound:
            DLog("************ ============ ************")
            DLog("******* NOT FOUND IN SERVER *******")
            completion(.doNotRetry)
        case .dependencyFail:
            DLog("************ ============ ************")
            DLog("******* BACKEND FAILD FOR DEPENDENCY *******")
            completion(.doNotRetry)
        case .serverProblem:
            DLog("************ ============ ************")
            DLog("******* BACKEND INTERNAL SERVER PROBLEM *******")
            completion(.doNotRetry)
        case .preconditioned:
            DLog("************ ============ ************")
            DLog("******* PRE CONDITION FAILED *******")
            completion(.doNotRetry)
        }
        
        
    }
}


/**
 use the bellow code, if refresh token mechanism needs to implement
 use the refreshToken method only
 if unauthorized request (401)
 */

/**
// Get the access token, and retry the api call
refreshToken { [weak self] result in
    guard let self = self else { return }

    switch result {
    case .success(let token):
        self.accessToken = token
        /// After updating the token we can safily retry the original request.
        completion(.retry)
    case .failure(let error):
        completion(.doNotRetryWithError(error))
    }
}
*/

/**
 private func refreshToken(_ completion:@escaping CompletionHandler<Any>) {
     // Here call the api to get access token.
     // set isRefreshing = false in api completion block
 }
 */

