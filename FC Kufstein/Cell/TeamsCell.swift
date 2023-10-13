//
//  TeamsCell.swift
//  FC Kufstein
//
//  Created by Adnann Muratovic on 13.10.23.
//

import UIKit

class TeamsCell: UITableViewCell {
    
    // MARK: - Properties
    static let cellID = "TeamsCell"
    
    // MARK: - Components
    let teamsContainerView = TeamsContainerView()
    
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
private extension TeamsCell {
    private func setupUI() {
        backgroundColor = .systemBackground
        setupTeamsContainerView()
    }
    
    private func setupTeamsContainerView() {
        contentView.addSubview(teamsContainerView)
        teamsContainerView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            teamsContainerView.topAnchor.constraint(equalTo: topAnchor, constant: 8),
            teamsContainerView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8),
            teamsContainerView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -8),
            teamsContainerView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -8),
        ])
    }
}
