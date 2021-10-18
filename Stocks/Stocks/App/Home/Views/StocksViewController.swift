//
//  StocksViewController.swift
//  Stocks
//
//  Created by Marlon David Ruiz Arroyave on 15/10/21.
//

import UIKit

class StocksViewController: BaseViewController {

    // MARK: - Variables

    var viewModel: StocksViewModelProtocol! {
        didSet {
            loadViewIfNeeded()

            viewModel.stocks.bind { [weak self] _ in
                self?.stockTableView.reloadData()
            }

            viewModel.shouldShowLoader = { [weak self] shouldShow in
                self?.shouldShowLoader(shouldShow)
            }

            viewModel.showAlert = { [weak self] message in
                self?.showAlert(msg: message)
            }
        }
    }

    lazy private var searchController: SearchBarController = {
        let searchController = SearchBarController("Search a Stock", delegate: self)
        searchController.searchBar.tintColor = .label
        searchController.showsCancelButton = !searchController.isSearchBarEmpty
        return searchController
    }()

    lazy private var stockTableView: UITableView = {
        let stockTableView = UITableView(frame: .zero)
        stockTableView.register(StockCell.self, forCellReuseIdentifier: StockCell.identifier)
        stockTableView.dataSource = self
        stockTableView.translatesAutoresizingMaskIntoConstraints = false
        return stockTableView
    }()

    // MARK: - Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        setupUI()
    }

    // MARK: - Private Functions

    private func setup() {
        title = "Stock Market!!!"
        navigationItem.searchController = searchController
        definesPresentationContext = true
    }

    private func setupUI() {
        view.addSubview(stockTableView)
        stockTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        stockTableView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        stockTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        stockTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
    }

}

// MARK: - SearchBarControllerDelegate

extension StocksViewController: SearchBarControllerDelegate {

    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        searchController.showsCancelButton = true
    }

    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        searchController.showsCancelButton = !searchController.isSearchBarEmpty
    }

    func textDidChange(searchText: String) {
        viewModel.updateSearchResults(for: searchText)
    }

    func cancelButtonTapped() {
        viewModel.cancelButtonTapped()
    }

}

// MARK: - UITableViewDataSource

extension StocksViewController: UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.stocks.value?.count ?? 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let viewModel = viewModel.makeViewModelForStockCell(at: indexPath)

        guard let cell = tableView.dequeueReusableCell(withIdentifier: StockCell.identifier,
                                                       for: indexPath) as? StockCell else {
            fatalError("Please review what's happening!")
        }

        cell.viewModel = viewModel
        return cell
    }

}
