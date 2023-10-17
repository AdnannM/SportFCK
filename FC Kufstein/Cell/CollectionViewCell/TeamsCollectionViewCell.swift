//
//  TeamsCollectionViewCell.swift
//  FC Kufstein
//
//  Created by Adnann Muratovic on 17.10.23.
//

import UIKit

class TeamsCollectionViewCell: UICollectionViewCell {
    
    // MARK: - Properties
    static let cellID = "TeamsCollectionViewCell"
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

private extension TeamsCollectionViewCell {
    private func setupUI() {
        backgroundColor = .orange
        layer.cornerRadius = 8
    }
}
