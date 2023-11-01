//
//  SeparatorView.swift
//  FC Kufstein
//
//  Created by Adnann Muratovic on 09.10.23.
//

import UIKit

protocol HomeContainerViewDelegate: AnyObject {
    func didTapAllMatch(_ view: HomeContainerView)
}

class HomeContainerView: UIView {
    
    // MARK: - Properties
    weak var delegate: HomeContainerViewDelegate?

    // MARK: - Components
    private let titleLabel = UILabel.createCustomLabel(
        text: "Next Match",
        textColor: .label,
        fontSize: 18,
        fontWeight: .black
    )
    
    private let allMatchButton = CustomButton(
        title: "All Match",
        hasBackground: false,
        fontSize: .med
    )
    
    let allMatchView = AllMatchView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupView()
    }
    
    override var intrinsicContentSize: CGSize {
        return CGSize(width: 200, height: 200)
    }
}

// MARK: - SetupUI
private extension HomeContainerView {
    private func setupView() {
        backgroundColor = .systemBackground
        layer.cornerRadius = 8
        translatesAutoresizingMaskIntoConstraints = false
        
        setupTitleLabel()
        setupAllMatchButton()
        setupAllMatchView()
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
    
    private func setupAllMatchButton() {
        addSubview(allMatchButton)
        allMatchButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            allMatchButton.centerYAnchor.constraint(equalTo: titleLabel.centerYAnchor),
            allMatchButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -8),
            allMatchButton.heightAnchor.constraint(equalToConstant: 30),
        ])
        
        allMatchButton.addTarget(self, action: #selector(didTapAllMatchButton), for: .touchUpInside)
    }
    
    private func setupAllMatchView() {
        addSubview(allMatchView)
        allMatchView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            allMatchView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 8),
            allMatchView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8),
            allMatchView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -8),
            allMatchView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
}

// MARK: - Action
extension HomeContainerView {
    @objc private func didTapAllMatchButton() {
        delegate?.didTapAllMatch(self)
    }
}
