//
//  NewsCollectionViewCell.swift
//  FC Kufstein
//
//  Created by Adnann Muratovic on 25.10.23.
//

import UIKit

class NewsCollectionViewCell: UICollectionViewCell {
    
    // MARK: - Properties
    static let cellID = "NewsCollectionViewCell"
    
    // MARK: - Components
    private let containerView = createView(color: .red)
    private let circleView = createView(color: .systemBackground)
    private let shareButtonView = createView(color: .label)
    
    // MARK: - Lifecycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - SetupUI
private extension NewsCollectionViewCell {
    private func setupUI() {
        
        setupContainerView()
        setupCircleView()
        setupShareButtonView()
    }
    
    private func setupContainerView() {
        contentView.addSubview(containerView)
        
        NSLayoutConstraint.activate([
            containerView.topAnchor.constraint(equalTo: contentView.topAnchor),
            containerView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            containerView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            containerView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
        ])
        
        containerView.layer.cornerRadius = 20
    }
    
    private func setupCircleView() {
        containerView.addSubview(circleView)
        
        NSLayoutConstraint.activate([
            circleView.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: 10),
            circleView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: 8),
            circleView.widthAnchor.constraint(equalToConstant: 100), // Set the width and height to create a circle
            circleView.heightAnchor.constraint(equalTo: circleView.widthAnchor),
        ])
        
        circleView.layer.cornerRadius = 50 // Set half of the width to make it circular
        circleView.clipsToBounds = true
    }
    
    private func setupShareButtonView() {
        circleView.addSubview(shareButtonView)
        
        NSLayoutConstraint.activate([
            shareButtonView.topAnchor.constraint(equalTo: circleView.topAnchor, constant: 10),
            shareButtonView.trailingAnchor.constraint(equalTo: circleView.trailingAnchor, constant: -10),
            shareButtonView.leadingAnchor.constraint(equalTo: circleView.leadingAnchor, constant: 10),
            shareButtonView.bottomAnchor.constraint(equalTo: circleView.bottomAnchor, constant: -10),
            
            shareButtonView.widthAnchor.constraint(equalToConstant: 80), // Set the width and height to create a circle
            shareButtonView.heightAnchor.constraint(equalTo: shareButtonView.widthAnchor),
        ])
        
         shareButtonView.clipsToBounds = true
         shareButtonView.layer.cornerRadius = 40
    }
}
