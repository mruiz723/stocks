//
//  APIClient.swift
//  Stocks
//
//  Created by Marlon David Ruiz Arroyave on 16/10/21.
//

import Foundation

protocol API {
    var baseURL: String { get }
    var networkDispatcher: NetworkDispatcherProtocol { get }
    func dispatch<R: Request>(_ request: R, completion:@escaping (Result<R.ReturnType, NetworkRequestError>) -> Void)
}

struct APIClient: API {
    let baseURL: String
    let networkDispatcher: NetworkDispatcherProtocol

    init(baseURL: String = Constants.baseURL, networkDispatcher: NetworkDispatcherProtocol = NetworkDispatcher()) {
        self.baseURL = baseURL
        self.networkDispatcher = networkDispatcher
    }

    /// Dispatches a Request and the completion has a Result
    /// - Parameter request: Request to Dispatch
    func dispatch<R: Request>(_ request: R, completion:@escaping (Result<R.ReturnType, NetworkRequestError>) -> Void) {
        guard let urlRequest = request.asURLRequest(baseURL: baseURL) else {
            completion(.failure(.badRequest()))
            return
        }

        networkDispatcher.dispatch(request: urlRequest, completion: completion)
    }
}
