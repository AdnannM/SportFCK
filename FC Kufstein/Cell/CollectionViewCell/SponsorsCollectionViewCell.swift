//
//  SponsorsCollectionViewCell.swift
//  FC Kufstein
//
//  Created by Adnann Muratovic on 18.10.23.
//

import UIKit

class SponsorsCollectionViewCell: UICollectionViewCell {
    
    // MARK: - Properties
    static let cellID = "SponsorsCollectionViewCell"
    
    // MARK: - Layout
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - SetupUI
private extension SponsorsCollectionViewCell {
    private func setupUI() {
        backgroundColor = .systemGray6.withAlphaComponent(0.7)
        layer.cornerRadius = 8
    }
}
