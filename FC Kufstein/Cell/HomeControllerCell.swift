//
//  HomeControllerCell.swift
//  FC Kufstein
//
//  Created by Adnann Muratovic on 11.10.23.
//

import UIKit

class HomeControllerCell: UITableViewCell {
    
    // MARK: - Properties
    static let cellID = "HomeControllerCell"
    
    // MARK: - Components
    let containerView = ContainerView()
    
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
private extension HomeControllerCell {
    private func setupUI() {
        setupContainerView()
    }
    
    private func setupContainerView() {
        contentView.addSubview(containerView)
        
        NSLayoutConstraint.activate([
            containerView.topAnchor.constraint(equalTo: topAnchor, constant: 8),
            containerView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8),
            containerView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -8),
            containerView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -8),
        ])
    }
}
