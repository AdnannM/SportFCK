//
//  TeamsCollectionViewCell.swift
//  FC Kufstein
//
//  Created by Adnann Muratovic on 17.10.23.
//

import UIKit

class TeamsCollectionViewCell: UICollectionViewCell {
    
    // MARK: - Properties
    static let cellID = "TeamsCollectionViewCell"
    
    // MARK: - Components
    private let teamsImage: UIImageView = {
        let imageView = UIImageView()
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFill
        imageView.layer.cornerRadius = 8
        return imageView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - SetupUI
private extension TeamsCollectionViewCell {
    private func setupUI() {
        backgroundColor = .systemGray6.withAlphaComponent(0.6)
        layer.cornerRadius = 8
        
        setupTeamsImage()
    }
    
    private func setupTeamsImage() {
        contentView.addSubview(teamsImage)
        teamsImage.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            teamsImage.topAnchor.constraint(equalTo: topAnchor),
            teamsImage.leadingAnchor.constraint(equalTo: leadingAnchor),
            teamsImage.trailingAnchor.constraint(equalTo: trailingAnchor),
            teamsImage.bottomAnchor.constraint(equalTo: bottomAnchor),
        ])
    }
}

// MARK: - ConfigureCell
extension TeamsCollectionViewCell {
    func configure(withModel model: TeamsModelData) {
        teamsImage.image = model.image
    }
}
