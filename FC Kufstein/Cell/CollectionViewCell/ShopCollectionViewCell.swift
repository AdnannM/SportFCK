//
//  ShopCollectionViewCell.swift
//  FC Kufstein
//
//  Created by Adnann Muratovic on 20.10.23.
//

import UIKit

class ShopCollectionViewCell: UICollectionViewCell {
    
    // MARK: - Properties
    static let cellID = "ShopCollectionViewCell"
    
    // MARK: - Lifecycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .red
        layer.cornerRadius = 8
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
