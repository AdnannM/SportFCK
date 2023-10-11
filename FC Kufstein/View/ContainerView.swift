//
//  SeparatorView.swift
//  FC Kufstein
//
//  Created by Adnann Muratovic on 09.10.23.
//

import UIKit

protocol ContainerViewDelegate: AnyObject {
    func didTapAllMatch(_ view: ContainerView)
}

class ContainerView: UIView {
    
    // MARK: - Properties
    weak var delegate: ContainerViewDelegate?

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
private extension ContainerView {
    private func setupView() {
        backgroundColor = .systemGray6
        layer.cornerRadius = 8
        translatesAutoresizingMaskIntoConstraints = false
        
        setupTitleLabel()
        setupAllMatchButton()
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
}

// MARK: - Action
extension ContainerView {
    @objc private func didTapAllMatchButton() {
        delegate?.didTapAllMatch(self)
    }
}
