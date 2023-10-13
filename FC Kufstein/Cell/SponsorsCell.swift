//
//  SponsorsCell.swift
//  FC Kufstein
//
//  Created by Adnann Muratovic on 13.10.23.
//

import UIKit

class SponsorsCell: UITableViewCell {
    
    // MARK: - Properties
    static let cellID = "SponsorsCell"
    
    // MARK: - Components
    let sponsorsContainerView = SponsorsContainerView()
    
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
private extension SponsorsCell {
    private func setupUI() {
        backgroundColor = .systemBackground
        setupSponsorsContainerView()
    }
    
    private func setupSponsorsContainerView() {
        contentView.addSubview(sponsorsContainerView)
        sponsorsContainerView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            sponsorsContainerView.topAnchor.constraint(equalTo: topAnchor, constant: 8),
            sponsorsContainerView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8),
            sponsorsContainerView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -8),
            sponsorsContainerView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -8),
        ])
    }
}
