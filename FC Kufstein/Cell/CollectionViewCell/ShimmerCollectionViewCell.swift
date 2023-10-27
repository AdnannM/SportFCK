//
//  ShimmerCollectionViewCell.swift
//  FC Kufstein
//
//  Created by Adnann Muratovic on 27.10.23.
//

// TODO: - Make shimmer for labels also
import UIKit
import SkeletonView


class ShimmerCollectionViewCell: UICollectionViewCell {
    
    static let cellID = "ShimmerCollectionViewCell"
    
    private let contentContainerView: UIView = {
        let view = UIView()
        view.backgroundColor = .systemGray6
        view.layer.cornerRadius = 20
        view.layer.masksToBounds = true
        return view
    }()
    
    private let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 8
        return stackView
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .label
        return label
    }()
    
    private let dateLabel: UILabel = {
        let label = UILabel()
        label.textColor = .secondaryLabel
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        contentView.addSubview(contentContainerView)
        contentContainerView.addSubview(stackView)
        stackView.addArrangedSubview(titleLabel)
        stackView.addArrangedSubview(dateLabel)
        
        setupConstraints()
        setupShimmerEffect()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupConstraints() {
        contentContainerView.translatesAutoresizingMaskIntoConstraints = false
        stackView.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        dateLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            contentContainerView.topAnchor.constraint(equalTo: contentView.topAnchor),
            contentContainerView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            contentContainerView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            contentContainerView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            
            stackView.topAnchor.constraint(equalTo: contentContainerView.topAnchor, constant: 16),
            stackView.leadingAnchor.constraint(equalTo: contentContainerView.leadingAnchor, constant: 16),
            stackView.trailingAnchor.constraint(equalTo: contentContainerView.trailingAnchor, constant: -16),
            
            titleLabel.heightAnchor.constraint(equalToConstant: 20),
            dateLabel.heightAnchor.constraint(equalToConstant: 16),
        ])
    }
    
    func setupShimmerEffect() {
        contentContainerView.isSkeletonable = true
        contentContainerView.showAnimatedGradientSkeleton()
        
        titleLabel.isSkeletonable = true
        titleLabel.showAnimatedGradientSkeleton()
        
        dateLabel.isSkeletonable = true
        dateLabel.showAnimatedGradientSkeleton()
    }
    
    func stopShimmer() {
        contentContainerView.hideSkeleton()
        titleLabel.hideSkeleton()
        dateLabel.hideSkeleton()
    }
}


