//
//  StocksViewControllerFactory.swift
//  Stocks
//
//  Created by Marlon David Ruiz Arroyave on 15/10/21.
//

import Foundation
import UIKit

struct StocksViewControllerFactory {

    static func makeViewController() -> StocksViewController {
        let viewModel = StocksViewModel()
        let viewController = StocksViewController.instantiate()
        viewController.viewModel = viewModel
        return viewController
    }

}
