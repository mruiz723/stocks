//
//  StocksViewModel.swift
//  Stocks
//
//  Created by Marlon David Ruiz Arroyave on 15/10/21.
//

import Foundation

protocol StocksViewModelProtocol: AnyObject, BaseViewModelProtocol {
    var stockRepository: StockRepositoryProtocol { get }
    var stocks: Bindable<[Stock]?> { get }
    func search(by word: String, limit: Int)
    func updateSearchResults(for text: String)
    func cancelButtonTapped()
    func makeViewModelForStockCell(at indexPath: IndexPath) -> StockViewModel
}

class StocksViewModel: StocksViewModelProtocol {
    var shouldShowLoader: ((Bool) -> Void)?
    var showAlert: ((String) -> Void)?
    var stockRepository: StockRepositoryProtocol
    private(set) var stocks: Bindable<[Stock]?> = Bindable(nil)
    private var invalidatedSearch: Bool = false

    init(stockRepository: StockRepositoryProtocol = StockRepository()) {
        self.stockRepository = stockRepository
    }

    func search(by word: String, limit: Int = 10) {
        shouldShowLoader?(true)
        stockRepository.fetchStocks(by: word, limit: limit) { result in
            DispatchQueue.main.async { [weak self] in
                guard let self = self else { return }
                self.shouldShowLoader?(false)
                switch result {
                case .success(let stocks):
                    guard !self.invalidatedSearch else { return }
                    self.stocks.value = stocks
                case .failure(let error):
                    self.showAlert?(error.localizedDescription)
                }
            }
        }
    }

    func updateSearchResults(for text: String) {
        if text.isEmpty {
            invalidatedSearch = true
            stocks.value = nil
        } else {
            invalidatedSearch = false
            search(by: text)
        }
    }

    func cancelButtonTapped() {
        stocks.value = nil
    }

    func makeViewModelForStockCell(at indexPath: IndexPath) -> StockViewModel {
        guard let stock = stocks.value?[indexPath.row] else {
            fatalError("A Stock is required")
        }

        return StockViewModel(stock: stock)
    }

}
