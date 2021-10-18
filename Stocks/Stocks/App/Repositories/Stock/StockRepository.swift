//
//  StockRepository.swift
//  Stocks
//
//  Created by Marlon David Ruiz Arroyave on 15/10/21.
//

import Foundation

typealias StockCompletion = (Result<[Stock], NetworkRequestError>) -> Void

protocol StockRepositoryProtocol {
    var apiClient: API { get }
    func fetchStocks(by word: String, limit: Int, completion: @escaping StockCompletion)
}

struct StockRepository: StockRepositoryProtocol {

    var apiClient: API

    init(apiClient: API = APIClient()) {
        self.apiClient = apiClient
    }

    func fetchStocks(by word: String, limit: Int, completion: @escaping StockCompletion) {
        let request = SearchStockRequest(by: word, limit: limit)
        apiClient.dispatch(request, completion: completion)
    }

}
