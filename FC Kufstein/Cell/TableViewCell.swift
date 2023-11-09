//
//  TableViewCell.swift
//  FC Kufstein
//
//  Created by Adnann Muratovic on 08.11.23.
//

import UIKit

class TableViewCell: UITableViewCell {
    
    // MARK: - Properties
    static let cellID = "TableViewCell"
    
    // MARK: - Components
    private let tableView = TableView()
    
    // MARK: - LifeCycle
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

// MARK: - SetupUI
private extension TableViewCell {
    private func setupUI() {
        setupTableView()
    }
    
    private func setupTableView() {
        contentView.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: contentView.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
    }
}

// MARK: - ConfigureCell
extension TableViewCell {
    func configure(with viewModel: TableEntryViewModel) {
        tableView.rankLabel.text = viewModel.rankText
        tableView.teamNameLabel.text = viewModel.teamNameText

        if let imageURL = viewModel.imageURL {
            tableView.logoImageView.sd_setImage(with: imageURL, completed: nil)
        }

        tableView.gamePlayesLabel.text = viewModel.gamePlayersText
        tableView.scoreDifferenceLabel.text = viewModel.scoreDifferenceText
        tableView.pointsLabel.text = viewModel.pointsText
    }
}


