//
//  FinishedMatchTableCell.swift
//  FC Kufstein
//
//  Created by Adnann Muratovic on 07.11.23.
//

import UIKit

class FinishedMatchTableCell: UITableViewCell {
    
    // MARK: - Properties
    static let cellID = "FinishedMatchTableCell"
    
    // MARK: - Component
    private let finishedMatchView = FinishedMatchView()
    
    // MARK: - LifeCycle
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - Setup
private extension FinishedMatchTableCell {
    private func setupUI() {
        setupFinishedMatchView()
    }
    
    private func setupFinishedMatchView() {
        contentView.addSubview(finishedMatchView)
        finishedMatchView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            finishedMatchView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            finishedMatchView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8),
            finishedMatchView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8),
            finishedMatchView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8)
        ])
    }
}
