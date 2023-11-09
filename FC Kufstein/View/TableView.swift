//
//  TableView.swift
//  FC Kufstein
//
//  Created by Adnann Muratovic on 08.11.23.
//

import UIKit

class TableView: UIView {
    
    // MARK: - Components
    let rankLabel = UILabel.createCustomLabel(
        text: "1.",
        textColor: .label,
        fontSize: 15,
        fontWeight: .bold
    )
    
    let logoView = UIView.createView(withColor: .white)
    let logoImageView = UIImageView.createImageView(withImage: UIImage(named: "fcklogo")!)
    
    let teamNameLabel = UILabel.createCustomLabel(
        text: "FC Kufstein",
        textColor: .label,
        fontSize: 15,
        fontWeight: .bold
    )
    
    private let stackView = UIStackView.createStackView()
    
    lazy var firstView = UIView.createView(withColor: .separator)
    lazy var secondView = UIView.createView(withColor: .separator)
    lazy var thirdView = UIView.createView(withColor: .separator)
    
    // MARK: - LifeCycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override var intrinsicContentSize: CGSize {
        return CGSize(width: 200, height: 80)
    }
}

// MARK: - SetupUI
private extension TableView {
    private func setupUI() {
        backgroundColor = .systemBackground
        
        setupRankLabel()
        setupLogoView()
        setupTeamNameLabel()
        setupStackView()
        
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
            teamNameLabel.topAnchor.constraint(equalTo: topAnchor, constant: 8),
            teamNameLabel.leadingAnchor.constraint(equalTo: logoView.trailingAnchor, constant: 8),
            teamNameLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -8),
            teamNameLabel.widthAnchor.constraint(equalToConstant: 150)
        ])
        
        teamNameLabel.numberOfLines = 2
        teamNameLabel.textAlignment = .left
    }
    
    private func setupStackView() {
        addSubview(stackView)
        stackView.addArrangedSubview(firstView)
        stackView.addArrangedSubview(secondView)
        stackView.addArrangedSubview(thirdView)
        
        stackView.spacing = 10
        NSLayoutConstraint.activate([
            stackView.centerYAnchor.constraint(equalTo: centerYAnchor), // Center the stackView vertically
            stackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -14),
            firstView.heightAnchor.constraint(equalToConstant: 30),
            firstView.widthAnchor.constraint(equalToConstant: 30),
            secondView.heightAnchor.constraint(equalToConstant: 30),
            secondView.widthAnchor.constraint(equalToConstant: 30),
            thirdView.heightAnchor.constraint(equalToConstant: 30),
            thirdView.widthAnchor.constraint(equalToConstant: 30),
        ])
        
        firstView.layer.cornerRadius = 8
        secondView.layer.cornerRadius = 8
        thirdView.layer.cornerRadius = 8
    }

}
