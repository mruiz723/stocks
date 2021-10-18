//
//  StockViewModelTests.swift
//  StocksTests
//
//  Created by Marlon David Ruiz Arroyave on 17/10/21.
//

import XCTest
@testable import Stocks

class StockViewModelTests: XCTestCase {

    private let stock = Stock(symbol: "AAPL", companyName: "Apple Inc.", price: "144.84")

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testInitShouldTriggerSymbolValue() {
        // Given
        let viewModel = StockViewModel(stock: stock)
        let exp = expectation(description: "symbol should be called")

        // When
        viewModel.symbol.bindAndFire { _ in
            exp.fulfill()
        }

        // Then
        waitForExpectations(timeout: 0.1)
        XCTAssertNotNil(viewModel.symbol.value, "symbol value should not be nil after excecuting it")
    }

    func testInitShouldTriggerCompanyNameValue() {
        // Given
        let viewModel = StockViewModel(stock: stock)
        let exp = expectation(description: "name should be called")

        // When
        viewModel.name.bindAndFire { _ in
            exp.fulfill()
        }

        // Then
        waitForExpectations(timeout: 0.1)
        XCTAssertNotNil(viewModel.symbol.value, "name value should not be nil after excecuting it")
    }

    func testInitShouldTriggerPriceValue() {
        // Given
        let viewModel = StockViewModel(stock: stock)
        let exp = expectation(description: "price should be called")

        // When
        viewModel.price.bindAndFire { _ in
            exp.fulfill()
        }

        // Then
        waitForExpectations(timeout: 0.1)
        XCTAssertNotNil(viewModel.symbol.value, "price value should not be nil after excecuting it")
    }
}
