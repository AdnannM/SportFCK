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
    
    let logoImage : UIImageView = {
        let imageView = UIImageView()
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFit
        imageView.layer.cornerRadius = 8
        let image = UIImage(named: "fcklogo")
        imageView.image = image
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
        contentView.addSubview(logoImage)
        teamsImage.translatesAutoresizingMaskIntoConstraints = false
        logoImage.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            teamsImage.topAnchor.constraint(equalTo: topAnchor),
            teamsImage.leadingAnchor.constraint(equalTo: leadingAnchor),
            teamsImage.trailingAnchor.constraint(equalTo: trailingAnchor),
            teamsImage.bottomAnchor.constraint(equalTo: bottomAnchor),
            
            logoImage.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10),
            logoImage.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            logoImage.heightAnchor.constraint(equalToConstant: 50),
            logoImage.widthAnchor.constraint(equalToConstant: 50)
        ])
    }
}

// MARK: - ConfigureCell
extension TeamsCollectionViewCell {
    func configure(withModel model: TeamsModelData) {
        teamsImage.image = model.image
    }
}
