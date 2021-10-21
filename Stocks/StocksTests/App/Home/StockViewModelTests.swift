//
//  StockViewModelTests.swift
//  StocksTests
//
//  Created by Marlon David Ruiz Arroyave on 17/10/21.
//

import XCTest
@testable import Stocks

class StockViewModelTests: XCTestCase {

    private var viewModel: StockViewModel!

    override func setUp() async throws {
        let stock = Stock(symbol: "AAPL", companyName: "Apple Inc.", price: "144.84")
        viewModel = StockViewModel(stock: stock)
    }

    override func tearDownWithError() throws {
        viewModel = nil
    }

    func testInitShouldTriggerSymbolValue() {
        // Given
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
        let exp = expectation(description: "name should be called")

        // When
        viewModel.name.bindAndFire { _ in
            exp.fulfill()
        }

        // Then
        waitForExpectations(timeout: 0.1)
        XCTAssertNotNil(viewModel.name.value, "name value should not be nil after excecuting it")
    }

    func testInitShouldTriggerPriceValue() {
        // Given
        let exp = expectation(description: "price should be called")

        // When
        viewModel.price.bindAndFire { _ in
            exp.fulfill()
        }

        // Then
        waitForExpectations(timeout: 0.1)
        XCTAssertNotNil(viewModel.price.value, "price value should not be nil after excecuting it")
    }

}
