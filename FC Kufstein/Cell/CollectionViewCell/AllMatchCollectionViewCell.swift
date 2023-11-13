//
//  AllMatchCollectionViewCell.swift
//  FC Kufstein
//
//  Created by Adnann Muratovic on 01.11.23.
//

import UIKit

class AllMatchCollectionViewCell: UICollectionViewCell {
    
    // MARK: - Properties
    static let cellID = "AllMatchCollectionViewCell"
    
    // MARK: - Components
    private let containerView = AllMatchContainerView()
    
    // MARK: - LifeCycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - SetupUI
private extension AllMatchCollectionViewCell {
    private func setupUI() {
        contentView.layer.cornerRadius = 20
        contentView.backgroundColor = .systemBackground
        
        setupContainerView()
    }
    
    private func setupContainerView() {
        contentView.addSubview(containerView)
        containerView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            containerView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            containerView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8),
            containerView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8),
            containerView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
        ])
    }
}

// MARK: - ConfigureCell
extension AllMatchCollectionViewCell {
    func configureCell(viewModel: UpcommingMatchViewModel) {
        
    }
}
