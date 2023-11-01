//
//  AllVideoTableViewCell.swift
//  FC Kufstein
//
//  Created by Adnann Muratovic on 23.10.23.
//

import UIKit

class AllVideoTableViewCell: UITableViewCell {
    
    // MARK: - Properties
    static let cellID = "AllVideoTableViewCell"
    
    // MARK: - Components
    private let containerView: UIView = {
        let view = UIView()
        view.backgroundColor = .systemBackground
        view.layer.cornerRadius = 20
        return view
    }()
    
    private let videoImage: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.backgroundColor = .systemBlue
        let image = UIImage(named: "videoImage")
        imageView.image = image
        imageView.layer.cornerRadius = 20
        return imageView
    }()
    
    private let titleView: UIView = {
        let view = UIView()
        view.backgroundColor = .systemBackground.withAlphaComponent(0.7)
        return view
    }()
    
    private let titleLabel = UILabel.createCustomLabel(
        text: "Kufstein U9 - 2023 10",
        textColor: .label,
        fontSize: 18,
        fontWeight: .medium
    )
    
    // MARK: - LifeCycle
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - Setup
private extension AllVideoTableViewCell {
    private func setupUI() {
        backgroundColor = .systemBackground
        
        setupContainerView()
        setupVideoImage()
        setupTitleView()
        setupTitleLabel()
        
    }
    
    private func setupContainerView() {
        contentView.addSubview(containerView)
        containerView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            containerView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            containerView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            containerView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            containerView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8)
        ])
    }
    
    private func setupVideoImage() {
        containerView.addSubview(videoImage)
        videoImage.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            videoImage.topAnchor.constraint(equalTo: containerView.topAnchor),
            videoImage.leadingAnchor.constraint(equalTo: containerView.leadingAnchor),
            videoImage.trailingAnchor.constraint(equalTo: containerView.trailingAnchor),
            videoImage.bottomAnchor.constraint(equalTo: containerView.bottomAnchor)
        ])
    }
    
    private func setupTitleView() {
        containerView.addSubview(titleView)  // Add titleView to containerView
        titleView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            titleView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor),
            titleView.bottomAnchor.constraint(equalTo: containerView.bottomAnchor),
            titleView.heightAnchor.constraint(equalToConstant: 40),
            titleView.widthAnchor.constraint(equalToConstant: 200)
        ])
        
        // Apply corner radius to the titleView
        titleView.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMinYCorner]
        titleView.layer.cornerRadius = 20
    }
    
    private func setupTitleLabel() {
        titleView.addSubview(titleLabel)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            titleLabel.leadingAnchor.constraint(equalTo: titleView.leadingAnchor, constant: 8),
            titleLabel.centerYAnchor.constraint(equalTo: titleView.centerYAnchor)
        ])
    }
}
