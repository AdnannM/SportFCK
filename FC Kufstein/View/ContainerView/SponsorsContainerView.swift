//
//  SponsorsContainerView.swift
//  FC Kufstein
//
//  Created by Adnann Muratovic on 13.10.23.
//

import UIKit

protocol SponsorsContainerViewDelegate: AnyObject {
    func didTapSponsors(_ view: SponsorsContainerView)
}

class SponsorsContainerView: UIView {
    
    // MARK: - Properties
    weak var delegate: SponsorsContainerViewDelegate?
    
    // MARK: - Components
    private let titleLabel = UILabel.createCustomLabel(
        text: "Sponsors",
        textColor: .label,
        fontSize: 18,
        fontWeight: .black
    )
    
    private let allSponsorsButton = CustomButton(
        title: "All Sponsors",
        hasBackground: false,
        fontSize: .med
    )
    
    private let sponsorsView = SponsorsView()
    
    // MARK: - Lifecycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    override var intrinsicContentSize: CGSize {
        return CGSize(width: 300, height: 300)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - SetupUI
private extension SponsorsContainerView {
    private func setupUI() {
        backgroundColor = .systemBackground
        
        setupTitleLabel()
        setupAllSponsorsButton()
        setupSponsorsView()
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
    
    private func setupAllSponsorsButton() {
        addSubview(allSponsorsButton)
        allSponsorsButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            allSponsorsButton.centerYAnchor.constraint(equalTo: titleLabel.centerYAnchor),
            allSponsorsButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -8),
            allSponsorsButton.heightAnchor.constraint(equalToConstant: 30),
        ])
        
        allSponsorsButton.addTarget(self, action: #selector(didTapAllSponsorsButton), for: .touchUpInside)
    }
    
    private func setupSponsorsView() {
        addSubview(sponsorsView)
        sponsorsView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            sponsorsView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 8),
            sponsorsView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8),
            sponsorsView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -8),
            sponsorsView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -8)
        ])
    }
}

// MARK: - Action
extension SponsorsContainerView {
    @objc private func didTapAllSponsorsButton() {
        delegate?.didTapSponsors(self)
    }
}
