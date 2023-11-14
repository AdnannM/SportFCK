//
//  ShimmerUpcommingMatchView.swift
//  FC Kufstein
//
//  Created by Adnann Muratovic on 14.11.23.
//

import UIKit

class ShimmerUpcommingMatchView: UIView {
    
    // MARK: - Components
    let gameLigaLabel = UILabel.createCustomLabel(
        text: "Regionalliga West | Nov 15, 2023 | 13:00",
        textColor: .label,
        fontSize: 14,
        fontWeight: .heavy
    )
    
    private let gameSeparator = UIView.createView(
        withColor: .separator
    )
    
    private let homeImageContainerView = createView(withColor: .white)
    private let guestImageContainerView = createView(withColor: .white)
    
    let homeImageView = UIImageView.createImageView(withImage: UIImage(named: "fcklogo")!)
    let guestImageView = UIImageView.createImageView(withImage: UIImage(named: "fcklogo")!)
    
    private lazy var scoreStackView = UIStackView.createStackView()
    
    private let homeScoreContainerView = createView(withColor: .separator)
    private let separatorScoreContainerView = createView(withColor: .separator)
    private let guestScoreContainerView = createView(withColor: .separator)
    
    let gamePlaceLabel = UILabel.createCustomLabel(
        text: "Kufstein Arena",
        textColor: .label,
        fontSize: 14,
        fontWeight: .heavy
    )
    
    let dayLabel = UILabel.createCustomLabel(
        text: "21",
        textColor: .label,
        fontSize: 20,
        fontWeight: .bold
    )
    
    let dayPlaceHolderLabel = UILabel.createCustomLabel(
        text: "days",
        textColor: .label,
        fontSize: 10,
        fontWeight: .bold
    )
    
    let minLabel = UILabel.createCustomLabel(
        text: "21",
        textColor: .label,
        fontSize: 20,
        fontWeight: .bold
    )
    
    let minPlaceHolderLabel = UILabel.createCustomLabel(
        text: "hrs",
        textColor: .label,
        fontSize: 10,
        fontWeight: .bold
    )
    
    let secLabel = UILabel.createCustomLabel(
        text: "21",
        textColor: .label,
        fontSize: 20,
        fontWeight: .bold
    )
    
    let secPlaceHolderLabel = UILabel.createCustomLabel(
        text: "mins",
        textColor: .label,
        fontSize: 10,
        fontWeight: .bold
    )
    
    // Constants
    private let cornerRadius: CGFloat = 12
    private let containerWidth: CGFloat = 80
    private let containerHeight: CGFloat = 80
    private let labelHeight: CGFloat = 40
    private let labelWidth: CGFloat = 40
    private let imageContainerSpacing: CGFloat = 25
    
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
        return CGSize(width: 200, height: 200)
    }
}

// MARK: - SetupUI
private extension ShimmerUpcommingMatchView {
    private func setupUI() {
        layer.cornerRadius = 20
        backgroundColor = .systemGray6.withAlphaComponent(0.8)
        
        setupHeadersLabels()
        setupLabelSeparator()
        setupHomeImageContainerView()
        setupGuestImageContainerView()
        setupScoreStackView()
        setupGamePlaceLabel()
        setupDaysCountView()
        setupMinCountView()
        setupSecCountView()
    }
    
    private func setupHeadersLabels() {
        addSubview(gameLigaLabel)
        gameLigaLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            gameLigaLabel.topAnchor.constraint(equalTo: topAnchor, constant: 20),
            gameLigaLabel.centerXAnchor.constraint(equalTo: centerXAnchor)
        ])
    }
    
    private func setupLabelSeparator() {
        addSubview(gameSeparator)
        gameSeparator.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            gameSeparator.topAnchor.constraint(equalTo: gameLigaLabel.bottomAnchor, constant: 4),
            gameSeparator.leadingAnchor.constraint(equalTo: gameLigaLabel.leadingAnchor),
            gameSeparator.trailingAnchor.constraint(equalTo: gameLigaLabel.trailingAnchor),
            gameSeparator.heightAnchor.constraint(equalToConstant: 1),
        ])
    }
    
    private func setupHomeImageContainerView() {
        setupImageContainerView(containerView: homeImageContainerView, imageView: homeImageView, leadingAnchor: leadingAnchor)
    }
    
    private func setupGuestImageContainerView() {
        setupImageContainerView(containerView: guestImageContainerView, imageView: guestImageView, trailingAnchor: trailingAnchor)
    }
    
    private func setupScoreStackView() {
        addSubview(scoreStackView)
        
        scoreStackView.addArrangedSubview(homeScoreContainerView)
        scoreStackView.addArrangedSubview(separatorScoreContainerView)
        scoreStackView.addArrangedSubview(guestScoreContainerView)
        
        scoreStackView.centerYAnchor.constraint(equalTo: homeImageContainerView.centerYAnchor).isActive = true
        scoreStackView.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        homeScoreContainerView.heightAnchor.constraint(equalToConstant: 40).isActive = true
        homeScoreContainerView.widthAnchor.constraint(equalToConstant: 40).isActive = true
        separatorScoreContainerView.heightAnchor.constraint(equalToConstant: 40).isActive = true
        separatorScoreContainerView.widthAnchor.constraint(equalToConstant: 40).isActive = true
        guestScoreContainerView.heightAnchor.constraint(equalToConstant: 40).isActive = true
        guestScoreContainerView.widthAnchor.constraint(equalToConstant: 40).isActive = true
        
        homeScoreContainerView.layer.cornerRadius = 12
        separatorScoreContainerView.layer.cornerRadius = 12
        guestScoreContainerView.layer.cornerRadius = 12
    }
    
    private func setupGamePlaceLabel() {
        addSubview(gamePlaceLabel)
        gamePlaceLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            gamePlaceLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -12),
            gamePlaceLabel.centerXAnchor.constraint(equalTo: centerXAnchor)
        ])
    }
    
    private func setupDaysCountView() {
        setupCountView(labels: [dayLabel, dayPlaceHolderLabel], containerView: homeScoreContainerView)
    }

    private func setupMinCountView() {
        setupCountView(labels: [minLabel, minPlaceHolderLabel], containerView: separatorScoreContainerView)
    }

    private func setupSecCountView() {
        setupCountView(labels: [secLabel, secPlaceHolderLabel], containerView: guestScoreContainerView)
    }
    
    // MARK: - Helpers
    private func setupImageContainerView(containerView: UIView, imageView: UIImageView, leadingAnchor: NSLayoutXAxisAnchor? = nil, trailingAnchor: NSLayoutXAxisAnchor? = nil) {
        addSubview(containerView)
        containerView.translatesAutoresizingMaskIntoConstraints = false
        
        containerView.addSubview(imageView)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            containerView.topAnchor.constraint(equalTo: gameSeparator.bottomAnchor, constant: imageContainerSpacing),
            (leadingAnchor != nil) ? containerView.leadingAnchor.constraint(equalTo: leadingAnchor!, constant: 20) : containerView.trailingAnchor.constraint(equalTo: trailingAnchor!, constant: -16),
            containerView.widthAnchor.constraint(equalToConstant: containerWidth),
            containerView.heightAnchor.constraint(equalToConstant: containerHeight),
            
            imageView.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 16),
            imageView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 16),
            imageView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -16),
            imageView.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -16),
        ])
        
        containerView.layer.cornerRadius = 40
        containerView.layer.masksToBounds = true
        imageView.layer.masksToBounds = true
    }
    
    private func setupCountView(labels: [UILabel], containerView: UIView, topConstant: CGFloat = 4, bottomConstant: CGFloat = -4) {
        // Create a vertical stack view to hold the provided labels
        let stackView = UIStackView(arrangedSubviews: labels)
        stackView.axis = .vertical
        stackView.spacing = 0 // Adjust the spacing between the labels

        containerView.addSubview(stackView)

        stackView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: containerView.topAnchor, constant: topConstant),
            stackView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor),
            stackView.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: bottomConstant)
        ])
    }
    
    func setupShimmerEffect() {
        
        gameLigaLabel.isSkeletonable = true
        gameLigaLabel.skeletonCornerRadius = 12
        gameLigaLabel.showAnimatedGradientSkeleton()
        
        homeImageContainerView.isSkeletonable = true
        homeImageContainerView.skeletonCornerRadius = 12
        homeImageContainerView.showAnimatedGradientSkeleton()
        
        guestImageContainerView.isSkeletonable = true
        guestImageContainerView.skeletonCornerRadius = 12
        guestImageContainerView.showAnimatedGradientSkeleton()
        
        homeScoreContainerView.isSkeletonable = true
        homeScoreContainerView.skeletonCornerRadius = 12
        homeScoreContainerView.showAnimatedGradientSkeleton()
        
        separatorScoreContainerView.isSkeletonable = true
        separatorScoreContainerView.skeletonCornerRadius = 12
        separatorScoreContainerView.showAnimatedGradientSkeleton()
        
        guestScoreContainerView.isSkeletonable = true
        guestScoreContainerView.skeletonCornerRadius = 12
        guestScoreContainerView.showAnimatedGradientSkeleton()
        
        gamePlaceLabel.isSkeletonable = true
        gamePlaceLabel.showAnimatedGradientSkeleton()
    }
    
    func stopShimmer() {
        gameLigaLabel.hideSkeleton()
        guestImageContainerView.hideSkeleton()
        homeScoreContainerView.hideSkeleton()
        separatorScoreContainerView.hideSkeleton()
        guestScoreContainerView.hideSkeleton()
        gamePlaceLabel.hideSkeleton()
    }
}

