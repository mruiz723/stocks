//
//  StockViewModel.swift
//  Stocks
//
//  Created by Marlon David Ruiz Arroyave on 15/10/21.
//

import Foundation

protocol StockViewModelProtocol {
    var symbol: Bindable<String> { get }
    var price: Bindable<String> { get }
    var name: Bindable<String> { get }
}

struct StockViewModel: StockViewModelProtocol {

    private let stock: Stock

    init(stock: Stock) {
        self.stock = stock
    }

    var symbol: Bindable<String> {
        return Bindable(stock.symbol)
    }

    var price: Bindable<String> {
        guard let price = stock.priceValue else {  return Bindable("") }

        return Bindable("$ \(price)")
    }

    var name: Bindable<String> {
        return Bindable(stock.companyName)
    }

}
