//
//  SponsorsCollectionViewCell.swift
//  FC Kufstein
//
//  Created by Adnann Muratovic on 18.10.23.
//

import UIKit

class SponsorsCollectionViewCell: UICollectionViewCell {
    
    // MARK: - Properties
    static let cellID = "SponsorsCollectionViewCell"
    
    private let sponsorsImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFit
        imageView.layer.borderWidth = 0.2
        imageView.layer.borderColor = UIColor.systemGray5.cgColor
        imageView.layer.cornerRadius = 8
        return imageView
    }()
    
    // MARK: - Layout
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - SetupUI
private extension SponsorsCollectionViewCell {
    private func setupUI() {
        backgroundColor = .systemGray6.withAlphaComponent(0.7)
        layer.cornerRadius = 8
        
        setupSponsorsImageView()
    }
    
    private func setupSponsorsImageView() {
        addSubview(sponsorsImageView)
        sponsorsImageView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            sponsorsImageView.topAnchor.constraint(equalTo: topAnchor),
            sponsorsImageView.leadingAnchor.constraint(equalTo: leadingAnchor),
            sponsorsImageView.trailingAnchor.constraint(equalTo: trailingAnchor),
            sponsorsImageView.bottomAnchor.constraint(equalTo: bottomAnchor),
        ])
    }
}

// MARK: - ConfigureCell
extension SponsorsCollectionViewCell {
    func configureCell(withModel model: SponsorsModelData) {
        sponsorsImageView.image = model.image
    }
}
