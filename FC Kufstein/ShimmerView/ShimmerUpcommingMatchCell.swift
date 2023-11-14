//
//  ShimmerUpcommingMatchCell.swift
//  FC Kufstein
//
//  Created by Adnann Muratovic on 14.11.23.
//

import UIKit

class ShimmerUpcommingMatchCell: UICollectionViewCell {
    
    // MARK: - Properties
    static let cellID = "ShimmerUpcommingMatchCell"
    
    // MARK: - Components
    private let containerView = ShimmerUpcommingMatchView()
    
    // MARK: - LifeCycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        // Reset any configurations or data here
        containerView.stopSkeletonAnimation() // Stop the shimmer animation if using a shimmer library
    }
}

// MARK: - SetupUI
private extension ShimmerUpcommingMatchCell {
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
        
        containerView.startSkeletonAnimation()
    }
}
