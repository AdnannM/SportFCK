//
//  ShopCollectionViewCell.swift
//  FC Kufstein
//
//  Created by Adnann Muratovic on 20.10.23.
//

import UIKit

class ShopCollectionViewCell: UICollectionViewCell {
    
    // MARK: - Properties
    static let cellID = "ShopCollectionViewCell"
    
    // MARK: - Components
    private let shopImage: UIImageView = {
        let imageView = UIImageView()
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFill
        imageView.layer.cornerRadius = 8
        return imageView
    }()
    
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
private extension ShopCollectionViewCell {
    private func setupUI() {
        backgroundColor = .red
        layer.cornerRadius = 8
        
        setupShopImageView()
    }
    
    private func setupShopImageView() {
        contentView.addSubview(shopImage)
        shopImage.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            shopImage.topAnchor.constraint(equalTo: contentView.topAnchor),
            shopImage.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            shopImage.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            shopImage.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
    }
}
