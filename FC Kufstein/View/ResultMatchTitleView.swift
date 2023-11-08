//
//  ResultMatchTitleView.swift
//  FC Kufstein
//
//  Created by Adnann Muratovic on 08.11.23.
//

import UIKit

class ResultMatchTitleView: UIView {
    
    // MARK: - Subview
    private let leftStackView = setupTableStackView(withSpacing: 8)
    private let leftOneTitleLabel = setupTableViewLabels(with: "#")
    private let leftTwoTitleLabel = setupTableViewLabels(with: "Mannschaft")
    private let rightStackView = setupTableStackView(withSpacing: 15)
    private let rightOneTitleLabel = setupTableViewLabels(with: "Sp.")
    private let rightTwoTitleLabel = setupTableViewLabels(with: "+/-")
    private let rightThereTitleLabel = setupTableViewLabels(with: "Pkt.")
    
    // MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override var intrinsicContentSize: CGSize {
        return CGSize(width: 200, height: 200)
    }
}

// MARK: - Setup
private extension ResultMatchTitleView {
    private func setupUI() {
        translatesAutoresizingMaskIntoConstraints = false
        setupLeftStackView()
        setupRightStackView()
    }
    
    private func setupLeftStackView() {
        addSubview(leftStackView)
        leftStackView.addArrangedSubview(leftOneTitleLabel)
        leftStackView.addArrangedSubview(leftTwoTitleLabel)
        
        leftStackView.topAnchor.constraint(equalTo: topAnchor).isActive = true
        leftStackView.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        leftStackView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
    }
    
    private func setupRightStackView() {
        addSubview(rightStackView)
        
        rightStackView.addArrangedSubview(rightOneTitleLabel)
        rightStackView.addArrangedSubview(rightTwoTitleLabel)
        rightStackView.addArrangedSubview(rightThereTitleLabel)
        
        rightStackView.topAnchor.constraint(equalTo: topAnchor).isActive = true
        trailingAnchor.constraint(equalTo: rightStackView.trailingAnchor, constant: 7).isActive = true
        rightStackView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
    }
}

/// Components for Match Table View Cell and Table View Cell
func setupTableViewLabels(with title: String) -> UILabel {
    let label = UILabel()
    label.translatesAutoresizingMaskIntoConstraints = false
    label.adjustsFontSizeToFitWidth = true
    label.font = .systemFont(ofSize: 18, weight: .medium)
    label.textColor = .label
    label.text = title
    return label
}
/// Create custom stack view
func setupTableStackView(withSpacing spacing: CGFloat) -> UIStackView {
    let stackView = UIStackView()
    stackView.translatesAutoresizingMaskIntoConstraints = false
    stackView.axis = .horizontal
    stackView.spacing = spacing
    return stackView
}
