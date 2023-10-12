//
//  NewsCellView.swift
//  FC Kufstein
//
//  Created by Adnann Muratovic on 12.10.23.
//

import UIKit

class NewsCell: UITableViewCell {
    
    // MARK: - Properties
    static let cellID = "NewsCell"
    
    // MARK: - Components
    let newsContainerView = NewsContainerView()
    
    // MARK: - Lifecycle
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - SetupUI
private extension NewsCell {
    private func setupUI() {
        backgroundColor = .systemBackground
        setupNewsContainerView()
    }
    
    private func setupNewsContainerView() {
        contentView.addSubview(newsContainerView)
        newsContainerView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            newsContainerView.topAnchor.constraint(equalTo: topAnchor, constant: 8),
            newsContainerView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8),
            newsContainerView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -8),
            newsContainerView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -8),
        ])
    }
}
