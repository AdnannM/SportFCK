//
//  LastMatchContainerView.swift
//  FC Kufstein
//
//  Created by Adnann Muratovic on 06.11.23.
//

import UIKit

class LastMatchContainerView: UIView {
    
    var gamePlace = UILabel.createCustomLabel(
        text: "Kufstein Arena",
        textColor: .label,
        fontSize: 15,
        fontWeight: .bold
    )
    
    let dateLabel = UILabel.createCustomLabel(
        text: "Sat, Nov 23, 2023",
        textColor: .label,
        fontSize: 14,
        fontWeight: .heavy
    )
    
    private let dateSeparator = createView(color: .separator)
    private let gameSeparator = createView(color: .separator)
    
    private let homeImageContainerView = createView(color: .white)
    private let guestImageContainerView = createView(color: .white)
    
    let homeImageView = UIImageView.createImageView(withImage: UIImage(named: "fcklogo")!)
    let guestImageView = UIImageView.createImageView(withImage: UIImage(named: "fcklogo")!)
    
    let homeScoreLabel = UILabel.createCustomLabel(
        text: "2",
        textColor: .label,
        fontSize: 60,
        fontWeight: .bold
    )
    
    let separatorLabel = UILabel.createCustomLabel(
        text: ":",
        textColor: .label,
        fontSize: 60,
        fontWeight: .bold
    )
    
    let guestScoreLabel = UILabel.createCustomLabel(
        text: "1",
        textColor: .label,
        fontSize: 60,
        fontWeight: .bold
    )
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .systemBackground.withAlphaComponent(0.6)
        layer.cornerRadius = 20
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override var intrinsicContentSize: CGSize {
        return CGSize(width: 200, height: 400)
    }
}

// MARK: - Setup
private extension LastMatchContainerView {
    private func setupUI() {
        setupLabels()
        setupSeparator()
        setupHomeImageContainerView()
        setupGuestImageContainerView()
        setupScoreLabel()
    }
    
    private func setupLabels() {
        addSubview(dateLabel)
        addSubview(gamePlace)
        dateLabel.translatesAutoresizingMaskIntoConstraints = false
        gamePlace.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            dateLabel.centerYAnchor.constraint(equalTo: gamePlace.centerYAnchor),
            dateLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            gamePlace.topAnchor.constraint(equalTo: topAnchor, constant: 16),
            gamePlace.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16)
        ])
    }
    
    private func setupSeparator() {
        addSubview(dateSeparator)
        addSubview(gameSeparator)
        
        dateSeparator.translatesAutoresizingMaskIntoConstraints = false
        gameSeparator.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            gameSeparator.topAnchor.constraint(equalTo: gamePlace.bottomAnchor, constant: 4),
            gameSeparator.leadingAnchor.constraint(equalTo: gamePlace.leadingAnchor),
            gameSeparator.trailingAnchor.constraint(equalTo: gamePlace.trailingAnchor),
            gameSeparator.heightAnchor.constraint(equalToConstant: 1),
            
            dateSeparator.topAnchor.constraint(equalTo: dateLabel.bottomAnchor, constant: 4),
            dateSeparator.leadingAnchor.constraint(equalTo: dateLabel.leadingAnchor),
            dateSeparator.trailingAnchor.constraint(equalTo: dateLabel.trailingAnchor),
            dateSeparator.heightAnchor.constraint(equalToConstant: 1),
        ])
    }
    
    private func setupHomeImageContainerView() {
        addSubview(homeImageContainerView)
        homeImageContainerView.translatesAutoresizingMaskIntoConstraints = false
        
        homeImageContainerView.addSubview(homeImageView)
        homeImageView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            homeImageContainerView.topAnchor.constraint(equalTo: dateSeparator.bottomAnchor, constant: 32),
            homeImageContainerView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            homeImageContainerView.widthAnchor.constraint(equalToConstant: 100),
            homeImageContainerView.heightAnchor.constraint(equalToConstant: 100),
            
            homeImageView.topAnchor.constraint(equalTo: homeImageContainerView.topAnchor, constant: 16),
            homeImageView.leadingAnchor.constraint(equalTo: homeImageContainerView.leadingAnchor, constant: 16),
            homeImageView.trailingAnchor.constraint(equalTo: homeImageContainerView.trailingAnchor, constant: -16),
            homeImageView.bottomAnchor.constraint(equalTo: homeImageContainerView.bottomAnchor, constant: -16),
            
        ])
        
        homeImageContainerView.layer.cornerRadius = 50
        homeImageContainerView.layer.masksToBounds = true
        homeImageView.layer.masksToBounds = true
    }
    
    private func setupGuestImageContainerView() {
        addSubview(guestImageContainerView)
        guestImageContainerView.translatesAutoresizingMaskIntoConstraints = false
        
        guestImageContainerView.addSubview(guestImageView)
        guestImageView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            guestImageContainerView.topAnchor.constraint(equalTo: gameSeparator.bottomAnchor, constant: 32),
            guestImageContainerView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            guestImageContainerView.widthAnchor.constraint(equalToConstant: 100),
            guestImageContainerView.heightAnchor.constraint(equalToConstant: 100),
            
            guestImageView.topAnchor.constraint(equalTo: guestImageContainerView.topAnchor, constant: 16),
            guestImageView.leadingAnchor.constraint(equalTo: guestImageContainerView.leadingAnchor, constant: 16),
            guestImageView.trailingAnchor.constraint(equalTo: guestImageContainerView.trailingAnchor, constant: -16),
            guestImageView.bottomAnchor.constraint(equalTo: guestImageContainerView.bottomAnchor, constant: -16),
        ])
        
        guestImageContainerView.layer.cornerRadius = 50
        guestImageContainerView.layer.masksToBounds = true
        guestImageView.layer.masksToBounds = true
    }
    
    private func setupScoreLabel() {
        addSubview(homeScoreLabel)
        addSubview(separatorLabel)
        addSubview(guestScoreLabel)
        
        homeScoreLabel.translatesAutoresizingMaskIntoConstraints = false
        separatorLabel.translatesAutoresizingMaskIntoConstraints = false
        guestScoreLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            homeScoreLabel.leadingAnchor.constraint(equalTo: homeImageContainerView.trailingAnchor, constant: 26),
            homeScoreLabel.centerYAnchor.constraint(equalTo: homeImageContainerView.centerYAnchor),
            
            separatorLabel.leadingAnchor.constraint(equalTo: homeScoreLabel.trailingAnchor, constant: 16),
            separatorLabel.centerYAnchor.constraint(equalTo: homeScoreLabel.centerYAnchor),

            guestScoreLabel.leadingAnchor.constraint(equalTo: separatorLabel.trailingAnchor, constant: 16),
            guestScoreLabel.centerYAnchor.constraint(equalTo: homeScoreLabel.centerYAnchor),
            guestScoreLabel.trailingAnchor.constraint(equalTo: guestImageContainerView.leadingAnchor, constant: -26)
        ])
    }
}
