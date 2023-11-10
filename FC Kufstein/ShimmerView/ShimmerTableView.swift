//
//  ShimmerTableView.swift
//  FC Kufstein
//
//  Created by Adnann Muratovic on 10.11.23.
//

import UIKit

class ShimmerTableView: UIView {
    
    // MARK: - Components
    lazy var rankLabel = UILabel.createCustomLabel(
        text: "1.",
        textColor: .label,
        fontSize: 15,
        fontWeight: .bold
    )
    
    lazy var logoView = UIView.createView(withColor: .white)
    lazy var logoImageView = UIImageView.createImageView(withImage: UIImage(named: "fcklogo")!)
    
    lazy var teamNameLabel = UILabel.createCustomLabel(
        text: "FC Kufstein",
        textColor: .label,
        fontSize: 15,
        fontWeight: .bold
    )
    
    private lazy var stackView = UIStackView.createStackView()
    
    lazy var gamePlayedView = UIView.createView(withColor: .separator)
    lazy var scoreDifferenceView = UIView.createView(withColor: .separator)
    lazy var pointsView = UIView.createView(withColor: .separator)
    
    lazy var gamePlayesLabel = UILabel.createCustomLabel(
        text: "-",
        textColor: .label,
        fontSize: 15,
        fontWeight: .bold
    )
    
    lazy var scoreDifferenceLabel = UILabel.createCustomLabel(
        text: "-",
        textColor: .label,
        fontSize: 15,
        fontWeight: .bold
    )
    
    lazy var pointsLabel = UILabel.createCustomLabel(
        text: "-",
        textColor: .label,
        fontSize: 15,
        fontWeight: .bold
    )
    
    
    // MARK: - LifeCycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
        setupShimmerEffect()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override var intrinsicContentSize: CGSize {
        return CGSize(width: 200, height: 80)
    }
}

// MARK: - SetupUI
private extension ShimmerTableView {
    private func setupUI() {
        backgroundColor = .systemBackground
        
        setupRankLabel()
        setupLogoView()
        setupTeamNameLabel()
        setupStackView()
        setupPointsLabel()
    }
    
    private func setupRankLabel() {
        addSubview(rankLabel)
        rankLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            rankLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8),
            rankLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
        ])
    }
    
    private func setupLogoView() {
        addSubview(logoView)
        logoView.addSubview(logoImageView)
        
        logoView.translatesAutoresizingMaskIntoConstraints = false
        logoImageView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            logoView.leadingAnchor.constraint(equalTo: rankLabel.trailingAnchor, constant: 8),
            logoView.centerYAnchor.constraint(equalTo: centerYAnchor),
            logoView.heightAnchor.constraint(equalToConstant: 48),
            logoView.widthAnchor.constraint(equalToConstant: 48),
            
            logoImageView.leadingAnchor.constraint(equalTo: logoView.leadingAnchor, constant: 4),
            logoImageView.topAnchor.constraint(equalTo: logoView.topAnchor, constant: 4),
            logoImageView.trailingAnchor.constraint(equalTo: logoView.trailingAnchor, constant: -4),
            logoImageView.bottomAnchor.constraint(equalTo: logoView.bottomAnchor, constant: -4)
        ])
        
        logoView.layer.cornerRadius = 8
    }
    
    private func setupTeamNameLabel() {
        
        addSubview(teamNameLabel)
        teamNameLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            teamNameLabel.centerYAnchor.constraint(equalTo: logoView.centerYAnchor),
            teamNameLabel.leadingAnchor.constraint(equalTo: logoView.trailingAnchor, constant: 8),
        ])
        
        teamNameLabel.numberOfLines = 2
        teamNameLabel.textAlignment = .left
    }
    
    private func setupStackView() {
        addSubview(stackView)
        stackView.addArrangedSubview(gamePlayedView)
        stackView.addArrangedSubview(scoreDifferenceView)
        stackView.addArrangedSubview(pointsView)
        
        stackView.spacing = 10
        NSLayoutConstraint.activate([
            stackView.centerYAnchor.constraint(equalTo: centerYAnchor), // Center the stackView vertically
            stackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -14),
            gamePlayedView.heightAnchor.constraint(equalToConstant: 30),
            gamePlayedView.widthAnchor.constraint(equalToConstant: 30),
            scoreDifferenceView.heightAnchor.constraint(equalToConstant: 30),
            scoreDifferenceView.widthAnchor.constraint(equalToConstant: 30),
            pointsView.heightAnchor.constraint(equalToConstant: 30),
            pointsView.widthAnchor.constraint(equalToConstant: 30),
        ])
        
        gamePlayedView.layer.cornerRadius = 8
        scoreDifferenceView.layer.cornerRadius = 8
        pointsView.layer.cornerRadius = 8
    }
    
    private func setupPointsLabel() {
        gamePlayedView.addSubview(gamePlayesLabel)
        scoreDifferenceView.addSubview(scoreDifferenceLabel)
        pointsView.addSubview(pointsLabel)
        
        gamePlayesLabel.translatesAutoresizingMaskIntoConstraints = false
        scoreDifferenceLabel.translatesAutoresizingMaskIntoConstraints = false
        pointsLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            gamePlayesLabel.centerXAnchor.constraint(equalTo: gamePlayedView.centerXAnchor),
            gamePlayesLabel.centerYAnchor.constraint(equalTo: gamePlayedView.centerYAnchor),
            
            scoreDifferenceLabel.centerXAnchor.constraint(equalTo: scoreDifferenceView.centerXAnchor),
            scoreDifferenceLabel.centerYAnchor.constraint(equalTo: scoreDifferenceView.centerYAnchor),
            
            pointsLabel.centerXAnchor.constraint(equalTo: pointsView.centerXAnchor),
            pointsLabel.centerYAnchor.constraint(equalTo: pointsView.centerYAnchor),
        ])
    }
    
    func setupShimmerEffect() {
        rankLabel.isSkeletonable = true
        rankLabel.showAnimatedGradientSkeleton()
        
        logoView.isSkeletonable = true
        logoView.skeletonCornerRadius = 12
        logoView.showAnimatedGradientSkeleton()
        
        teamNameLabel.isSkeletonable = true
        teamNameLabel.showAnimatedGradientSkeleton()
        
        gamePlayedView.isSkeletonable = true
        gamePlayedView.skeletonCornerRadius = 12
        gamePlayedView.showAnimatedGradientSkeleton()
        
        scoreDifferenceView.isSkeletonable = true
        scoreDifferenceView.skeletonCornerRadius = 12
        scoreDifferenceView.showAnimatedGradientSkeleton()
        
        pointsView.isSkeletonable = true
        pointsView.skeletonCornerRadius = 12
        pointsView.showAnimatedGradientSkeleton()
    }
    
    func stopShimmer() {
        rankLabel.hideSkeleton()
        logoView.hideSkeleton()
        teamNameLabel.hideSkeleton()
        gamePlayedView.hideSkeleton()
        scoreDifferenceView.hideSkeleton()
        pointsView.hideSkeleton()
    }
}
