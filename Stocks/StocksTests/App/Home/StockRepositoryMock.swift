//
//  StockRepositoryMock.swift
//  StocksTests
//
//  Created by Marlon David Ruiz Arroyave on 17/10/21.
//

import Foundation
@testable import Stocks

struct StockRepositoryMock: StockRepositoryProtocol {

    var apiClient: API
    var stocks: [Stock]?

    init(apiClient: API = APIClient()) {
        self.apiClient = apiClient
    }

    func fetchStocks(by word: String, limit: Int, completion: @escaping StockCompletion) {
        guard let stocks = stocks else {
            completion(.failure(.badRequest(Constants.ErrorMessage.title)))
            return
        }

        completion(.success(stocks))
    }

}
