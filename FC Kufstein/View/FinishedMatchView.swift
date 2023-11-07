//
//  FinishedMatchView.swift
//  FC Kufstein
//
//  Created by Adnann Muratovic on 07.11.23.
//

import UIKit

class FinishedMatchView: UIView {
    
    // MARK: - Components
    let gameLigaLabel = UILabel.createCustomLabel(
        text: "Regionalliga West",
        textColor: .label,
        fontSize: 14,
        fontWeight: .heavy
    )
    
    private let gameSeparator = createView(color: .separator)
    
    private let homeImageContainerView = createView(color: .white)
    private let guestImageContainerView = createView(color: .white)
    
    let homeImageView = UIImageView.createImageView(withImage: UIImage(named: "fcklogo")!)
    let guestImageView = UIImageView.createImageView(withImage: UIImage(named: "fcklogo")!)
    
    private lazy var scoreStackView = UIStackView.createStackView()
    
    private let homeScoreContainerView = createView(color: .separator)
    private let separatorScoreContainerView = createView(color: .separator)
    private let guestScoreContainerView = createView(color: .separator)
    
    let halfTimeScore = UILabel.createCustomLabel(
        text: "(0:0)",
        textColor: .label,
        fontSize: 14,
        fontWeight: .light
    )
    
    let gamePlaceLabel = UILabel.createCustomLabel(
        text: "Kufstein Arena",
        textColor: .label,
        fontSize: 14,
        fontWeight: .heavy
    )
    
    // MARK: - LifeCycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override var intrinsicContentSize: CGSize {
        return CGSize(width: 200, height: 185)
    }
}

// MARK: - Setup
private extension FinishedMatchView {
    private func setupUI() {
        layer.cornerRadius = 20
        backgroundColor = .systemGray6
        
        setupHeadersLabels()
        setupLabelSeparator()
        setupHomeImageContainerView()
        setupGuestImageContainerView()
        setupScoreStackView()
        setupHalfTimeScore()
        setupGamePlaceLabel()
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
        addSubview(homeImageContainerView)
        homeImageContainerView.translatesAutoresizingMaskIntoConstraints = false
        
        homeImageContainerView.addSubview(homeImageView)
        homeImageView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            homeImageContainerView.topAnchor.constraint(equalTo: gameSeparator.bottomAnchor, constant: 16),
            homeImageContainerView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            homeImageContainerView.widthAnchor.constraint(equalToConstant: 80),
            homeImageContainerView.heightAnchor.constraint(equalToConstant: 80),
            
            homeImageView.topAnchor.constraint(equalTo: homeImageContainerView.topAnchor, constant: 16),
            homeImageView.leadingAnchor.constraint(equalTo: homeImageContainerView.leadingAnchor, constant: 16),
            homeImageView.trailingAnchor.constraint(equalTo: homeImageContainerView.trailingAnchor, constant: -16),
            homeImageView.bottomAnchor.constraint(equalTo: homeImageContainerView.bottomAnchor, constant: -16),
            
        ])
        
        homeImageContainerView.layer.cornerRadius = 40
        homeImageContainerView.layer.masksToBounds = true
        homeImageView.layer.masksToBounds = true
    }
    
    private func setupGuestImageContainerView() {
        addSubview(guestImageContainerView)
        guestImageContainerView.translatesAutoresizingMaskIntoConstraints = false
        
        guestImageContainerView.addSubview(guestImageView)
        guestImageView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            guestImageContainerView.topAnchor.constraint(equalTo: gameSeparator.bottomAnchor, constant: 16),
            guestImageContainerView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            guestImageContainerView.widthAnchor.constraint(equalToConstant: 80),
            guestImageContainerView.heightAnchor.constraint(equalToConstant: 80),
            
            guestImageView.topAnchor.constraint(equalTo: guestImageContainerView.topAnchor, constant: 16),
            guestImageView.leadingAnchor.constraint(equalTo: guestImageContainerView.leadingAnchor, constant: 16),
            guestImageView.trailingAnchor.constraint(equalTo: guestImageContainerView.trailingAnchor, constant: -16),
            guestImageView.bottomAnchor.constraint(equalTo: guestImageContainerView.bottomAnchor, constant: -16),
        ])
        
        guestImageContainerView.layer.cornerRadius = 40
        guestImageContainerView.layer.masksToBounds = true
        guestImageView.layer.masksToBounds = true
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
    
    private func setupHalfTimeScore() {
        addSubview(halfTimeScore)
        halfTimeScore.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            halfTimeScore.topAnchor.constraint(equalTo: scoreStackView.bottomAnchor, constant: 4),
            halfTimeScore.centerXAnchor.constraint(equalTo: centerXAnchor)
        ])
    }
    
    private func setupGamePlaceLabel() {
        addSubview(gamePlaceLabel)
        gamePlaceLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            gamePlaceLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -8),
            gamePlaceLabel.centerXAnchor.constraint(equalTo: centerXAnchor)
        ])
    }
}
