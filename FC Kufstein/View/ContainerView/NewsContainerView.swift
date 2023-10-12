//
//  NewsContainerView.swift
//  FC Kufstein
//
//  Created by Adnann Muratovic on 12.10.23.
//

import UIKit

protocol NewsContainerViewDelegate: AnyObject {
    func didTapAllNews(_ view: NewsContainerView)
}

class NewsContainerView: UIView {
    
    // MARK: - Properties
    weak var delegate: NewsContainerViewDelegate?
    
    // MARK: - Components
    private let titleLabel = UILabel.createCustomLabel(
        text: "Last News",
        textColor: .label,
        fontSize: 18,
        fontWeight: .black
    )
    
    private let allNewsButton = CustomButton(
        title: "All News",
        hasBackground: false,
        fontSize: .med
    )
    
    private let newsView = NewsView()
    
    // MARK: - Lifecycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override var intrinsicContentSize: CGSize {
        return CGSize(width: 150, height: 150)
    }
}

// MARK: - SetupUI
private extension NewsContainerView {
    private func setupUI() {
        backgroundColor = .systemBackground
        setupTitleLabel()
        setupAllNewsButton()
        setupNewsView()
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
        addSubview(allNewsButton)
        allNewsButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            allNewsButton.centerYAnchor.constraint(equalTo: titleLabel.centerYAnchor),
            allNewsButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -8),
            allNewsButton.heightAnchor.constraint(equalToConstant: 30),
        ])
        
        allNewsButton.addTarget(self, action: #selector(didTapAllNewsButton), for: .touchUpInside)
    }
    
    private func setupNewsView() {
        addSubview(newsView)
        newsView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            newsView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 8),
            newsView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8),
            newsView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -8),
            newsView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -8)
        ])
    }
}

// MARK: - Action
extension NewsContainerView {
    @objc private func didTapAllNewsButton() {
        delegate?.didTapAllNews(self)
    }
}
