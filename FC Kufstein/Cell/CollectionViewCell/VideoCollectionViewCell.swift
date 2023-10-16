//
//  VideoCollectionViewCell.swift
//  FC Kufstein
//
//  Created by Adnann Muratovic on 16.10.23.
//

import UIKit

class VideoCollectionViewCell: UICollectionViewCell {
    
    // MARK: - Properties
    static let cellID = "VideoCollectionViewCell"
    
    // MARK: - Lifecycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - SetupUI
private extension VideoCollectionViewCell {
    private func setupUI() {
        backgroundColor = .orange
        contentView.clipsToBounds = true
    }
}
