//
//  StockCell.swift
//  Stocks
//
//  Created by Marlon David Ruiz Arroyave on 15/10/21.
//

import UIKit

class StockCell: UITableViewCell {

    static let identifier: String = "StockCell"

    var viewModel: StockViewModelProtocol! {
        didSet {
            viewModel.symbol.bindAndFire { [weak self] symbol in
                self?.symbolLabel.text = symbol
            }

            viewModel.name.bindAndFire { [weak self] name in
                self?.nameLabel.text = name
            }

            viewModel.price.bindAndFire { [weak self] price in
                self?.priceLabel.text = price
            }
        }
    }

    lazy private var symbolLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .boldSystemFont(ofSize: 20)
        label.textColor = .label
        label.textAlignment = .left
        return label
    }()

    lazy private var nameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .boldSystemFont(ofSize: 17)
        label.textColor = .label.withAlphaComponent(0.60)
        return label
    }()

    lazy private var priceLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .boldSystemFont(ofSize: 20)
        label.textColor = .label
        label.textAlignment = .right
        return label
    }()

    lazy private var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.spacing = 20
        stackView.alignment = .center
        stackView.distribution = .equalSpacing
        return stackView
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupUI()
    }

    private func setupUI() {
        contentView.addSubview(stackView)
        contentView.addSubview(nameLabel)
        stackView.addArrangedSubview(symbolLabel)
        stackView.addArrangedSubview(priceLabel)
        let horizontalMargin: CGFloat = 20.0
        let verticalMargin: CGFloat = 10.0

        stackView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: verticalMargin).isActive = true
        stackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: horizontalMargin).isActive = true
        stackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -horizontalMargin).isActive = true

        nameLabel.topAnchor.constraint(equalTo: stackView.bottomAnchor, constant: 0).isActive = true
        nameLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: horizontalMargin).isActive = true
        nameLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -horizontalMargin).isActive = true
        nameLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -verticalMargin).isActive = true
    }

}
