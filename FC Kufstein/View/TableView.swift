//
//  TableView.swift
//  FC Kufstein
//
//  Created by Adnann Muratovic on 08.11.23.
//

import UIKit

class TableView: UIView {
    // MARK: - Components
    
    // MARK: - LifeCycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override var intrinsicContentSize: CGSize {
        return CGSize(width: 200, height: 80)
    }
}

// MARK: - SetupUI
private extension TableView {
    private func setupUI() {
        backgroundColor = .systemBackground
    }
}
