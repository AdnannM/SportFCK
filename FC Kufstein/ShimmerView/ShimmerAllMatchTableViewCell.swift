//
//  ShimmerAllMatchTableViewCell.swift
//  FC Kufstein
//
//  Created by Adnann Muratovic on 14.11.23.
//

import UIKit

class ShimmerAllMatchTableViewCell: UITableViewCell {
    
    // MARK: - Properties
    static let cellID = "ShimmerAllMatchTableViewCell"
    
    private lazy var containerView = ShimmerUpcommingMatchView()
    
    // MARK: - LifeCycle
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        containerView.startSkeletonAnimation()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        // Reset any configurations or data here
        containerView.stopSkeletonAnimation()
    }
    
}

// MARK: - SetupUI
private extension ShimmerAllMatchTableViewCell {
    private func setupUI() {
        setupContainerView()
    }
    
    private func setupContainerView() {
        contentView.addSubview(containerView)
        containerView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            containerView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            containerView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8),
            containerView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8),
            containerView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8),
        ])
        
        containerView.startSkeletonAnimation()
    }
}
