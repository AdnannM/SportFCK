//
//  VideoCell.swift
//  FC Kufstein
//
//  Created by Adnann Muratovic on 12.10.23.
//

import UIKit

class VideoCell: UITableViewCell {
    
    // MARK: - Properties
    static let cellID = "VideoCell"
    
    // MARK: - Components
    let videoContainerView = VideoContainerView()
    
    // MARK: - Lifecycle
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - SetupUI
private extension VideoCell {
    private func setupUI() {
        backgroundColor = .systemBackground
        
        setupVideoContainerView()
    }
    
    private func setupVideoContainerView() {
        contentView.addSubview(videoContainerView)
        videoContainerView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            videoContainerView.topAnchor.constraint(equalTo: topAnchor, constant: 8),
            videoContainerView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8),
            videoContainerView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -8),
            videoContainerView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -8),
        ])
    }
}
