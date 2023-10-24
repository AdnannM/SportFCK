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
        imageView.contentMode = .scaleAspectFit
        imageView.layer.cornerRadius = 8
        return imageView
    }()
    
    private let containerView: UIView = {
        let view = UIView()
        view.backgroundColor = .systemGray6.withAlphaComponent(0.7)
        return view
    }()
    
    private let titleLabel = UILabel.createCustomLabel(
        text: "Title Label",
        textColor: .label.withAlphaComponent(0.5)
        , fontSize: 16,
        fontWeight: .regular
    )
    
    private let priceLabel = UILabel.createCustomLabel(
        text: "Price Label",
        textColor: .label
        , fontSize: 14,
        fontWeight: .bold
    )
    
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
        backgroundColor = .white
        layer.cornerRadius = 20
        
        setupShopImageView()
        setupContainerView()
        setupTitleLabel()
        setupPriceLabel()
    }
    
    private func setupShopImageView() {
        contentView.addSubview(shopImage)
        shopImage.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            shopImage.topAnchor.constraint(equalTo: contentView.topAnchor),
            shopImage.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            shopImage.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            shopImage.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -50)
        ])
    }
    
    private func setupContainerView() {
        contentView.addSubview(containerView)
        containerView.translatesAutoresizingMaskIntoConstraints = false
        
        containerView.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]
        containerView.layer.cornerRadius = 20

        
        NSLayoutConstraint.activate([
            containerView.topAnchor.constraint(equalTo: shopImage.bottomAnchor),
            containerView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            containerView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            containerView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
        ])
    }
    
    private func setupTitleLabel() {
        containerView.addSubview(titleLabel)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 4),
            titleLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 8),
            titleLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -4)
        ])
    }
    
    private func setupPriceLabel() {
        containerView.addSubview(priceLabel)
        priceLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            priceLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 4),
            priceLabel.centerXAnchor.constraint(equalTo: containerView.centerXAnchor)
        ])
    }
}

// MARK: - ConfigureCell
extension ShopCollectionViewCell {
    func configure(withModel model: ShopDataModel) {
        shopImage.image = model.image
        titleLabel.text = model.title.capitalized
        priceLabel.text = model.price
    }
}

