//
//  ShimmerTableViewCell.swift
//  FC Kufstein
//
//  Created by Adnann Muratovic on 10.11.23.
//

import UIKit

class ShimmerTableViewCell: UITableViewCell {
    
    // MARK: - Properties
    static let cellID = "ShimmerTableViewCell"
    
    // MARK: - Components
    private let shimmerTableView = ShimmerTableView()
    
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
private extension ShimmerTableViewCell {
    private func setupUI() {
        setupTableView()
    }
    
    private func setupTableView() {
        contentView.addSubview(shimmerTableView)
        shimmerTableView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            shimmerTableView.topAnchor.constraint(equalTo: contentView.topAnchor),
            shimmerTableView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            shimmerTableView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            shimmerTableView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
        
        shimmerTableView.startSkeletonAnimation()
    }
}
