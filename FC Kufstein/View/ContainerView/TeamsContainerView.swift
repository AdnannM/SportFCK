//
//  TeamsContainerView.swift
//  FC Kufstein
//
//  Created by Adnann Muratovic on 13.10.23.
//

import UIKit

protocol TeamsContainerViewDelegate: AnyObject {
    func didTapTeams(_ view: TeamsContainerView)
}

class TeamsContainerView: UIView {
    
    // MARK: - Properties
    weak var delegate: TeamsContainerViewDelegate?
    
    // MARK: - Components
    private let titleLabel = UILabel.createCustomLabel(
        text: "Teams",
        textColor: .label,
        fontSize: 18,
        fontWeight: .black
    )
    
    private let allTeamsButton = CustomButton(
        title: "All Teams",
        hasBackground: false,
        fontSize: .med
    )
    
    private let teamsView = TeamsView()
    
    // MARK: - Lifecycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override var intrinsicContentSize: CGSize {
        return CGSize(width: 200, height: 200)
    }
    
}

// MARK: - SetupUI
private extension TeamsContainerView {
    private func setupUI() {
        backgroundColor = .systemBackground
        setupTitleLabel()
        setupAllNewsButton()
        setupTeamsView()
    }
    
    private func setupTitleLabel() {
        addSubview(titleLabel)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: topAnchor, constant: 8),
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8),
            titleLabel.heightAnchor.constraint(equalToConstant: 30)
        ])
    }
    
    private func setupAllNewsButton() {
        addSubview(allTeamsButton)
        allTeamsButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            allTeamsButton.centerYAnchor.constraint(equalTo: titleLabel.centerYAnchor),
            allTeamsButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -8),
            allTeamsButton.heightAnchor.constraint(equalToConstant: 30),
        ])
        
        allTeamsButton.addTarget(self, action: #selector(didTapAllTeamsButton), for: .touchUpInside)
    }
    
    private func setupTeamsView() {
        addSubview(teamsView)
        teamsView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            teamsView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 8),
            teamsView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8),
            teamsView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -8),
            teamsView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -8)
        ])
    }
}

// MARK: - Action
extension TeamsContainerView {
    @objc private func didTapAllTeamsButton() {
        delegate?.didTapTeams(self)
    }
}
