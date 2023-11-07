//
//  ShimmerFinishedMatchTableCell.swift
//  FC Kufstein
//
//  Created by Adnann Muratovic on 07.11.23.
//

import UIKit

class ShimmerFinishedMatchTableCell: UITableViewCell {
    
    static let cellID = "ShimmerFinishedMatchTableCell"
    
    private let shimmerView: ShimmerFinishedMatchView = {
        let view = ShimmerFinishedMatchView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupUI() {
        contentView.addSubview(shimmerView)
        NSLayoutConstraint.activate([
            shimmerView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            shimmerView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8),
            shimmerView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8),
            shimmerView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8)
        ])
        

        // Apply shimmer animation to shimmerView here
        shimmerView.startSkeletonAnimation()
    }
}
