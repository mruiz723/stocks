//
//  StocksViewModelTests.swift
//  StocksTests
//
//  Created by Marlon David Ruiz Arroyave on 17/10/21.
//

import XCTest
@testable import Stocks

class StocksViewModelTests: XCTestCase {

    private var stockRepositoryMock: StockRepositoryMock!
    private var viewModel: StocksViewModel!
    private let stock = Stock(symbol: "AAPL", companyName: "Apple Inc.", price: "144.84")

    override func tearDownWithError() throws {
        stockRepositoryMock = nil
        viewModel = nil
    }

    func testInit() {
        stockRepositoryMock = StockRepositoryMock()
        viewModel = StocksViewModel(stockRepository: stockRepositoryMock)
        XCTAssertNil(viewModel.stocks.value, "stocks should be nil")
    }

    func testLoadDataWithStocksResultShouldTriggerStocksWithNotNilValues() {
        // Given
        stockRepositoryMock = StockRepositoryMock()
        stockRepositoryMock.stocks = [stock]
        viewModel = StocksViewModel(stockRepository: stockRepositoryMock)
        let exp = expectation(description: "stocks should be called")

        // When
        viewModel.stocks.bind { _ in
            exp.fulfill()
        }

        viewModel.search(by: "A")

        // then
        waitForExpectations(timeout: 0.1)
        XCTAssertNotNil(viewModel.stocks.value, "stocks value should not be nil after excecuting it")
    }

    func testLoadDataWithoutStocksResultShouldTriggerShowAlertEvent() {
        // Given
        stockRepositoryMock = StockRepositoryMock()
        viewModel = StocksViewModel(stockRepository: stockRepositoryMock)
        let exp = expectation(description: "showAlert event should be called")

        // When
        viewModel.showAlert = { _ in
            exp.fulfill()
        }

        viewModel.search(by: "$")

        // then
        waitForExpectations(timeout: 0.1)
        XCTAssertNotNil(viewModel.showAlert, "showAlert should not be nil after excecuting it")
    }

    func testUpdateSearchResultsWithEmptyStringShouldTriggerStocksWithNilValue() {
        // Given
        stockRepositoryMock = StockRepositoryMock()
        viewModel = StocksViewModel(stockRepository: stockRepositoryMock)

        // When
        viewModel.updateSearchResults(for: "")

        // then
        viewModel.stocks.bind { stocks in
            XCTAssertNil(stocks, "Stocks should be nil")
        }
    }

    func testUpdateSearchResultsWithAStringShouldTriggerStocksWithNotNilValues() {
        // Given
        stockRepositoryMock = StockRepositoryMock()
        stockRepositoryMock.stocks = [stock]
        viewModel = StocksViewModel(stockRepository: stockRepositoryMock)

        // When
        viewModel.updateSearchResults(for: "A")

        // then
        viewModel.stocks.bind { stocks in
            XCTAssertNotNil(stocks, "stocks should not be nil after excecuting it")
        }

    }

    func testCancelButtonTappedShouldTriggerStocksWithNilValue() {
        // Given
        stockRepositoryMock = StockRepositoryMock()
        viewModel = StocksViewModel(stockRepository: stockRepositoryMock)

        // When
        viewModel.cancelButtonTapped()

        // Then
        viewModel.stocks.bind { stocks in
            XCTAssertNil(stocks, "Stocks should be nil")
        }
    }

    func testMakeViewModelForStockCellShouldReturnAStockViewModelObject() {
        // Given
        stockRepositoryMock = StockRepositoryMock()
        stockRepositoryMock.stocks = [stock]
        viewModel = StocksViewModel(stockRepository: stockRepositoryMock)
        let exp = expectation(description: "stock event should be called")

        // When
        viewModel.stocks.bind { _ in
            exp.fulfill()
        }

        viewModel.search(by: "A")
        waitForExpectations(timeout: 0.1)
        let indexPath = IndexPath(row: 0, section: 0)
        let stockViewModel =  viewModel.makeViewModelForStockCell(at: indexPath)

        // Then
        XCTAssertNotNil(viewModel.stocks.value, "stocks should not be nil")
        XCTAssertNotNil(stockViewModel, "stockViewModel should not be nil")
    }

}
