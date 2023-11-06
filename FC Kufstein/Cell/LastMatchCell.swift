//
//  LastMatchCell.swift
//  FC Kufstein
//
//  Created by Adnann Muratovic on 06.11.23.
//

import UIKit

class LastMatchCell: UITableViewCell {
    
    // MARK: - Properties
    static let cellID = "LastMatchCell"
    
    // MARK: - Components
    private let lastMatchContainerView = LastMatchContainerView()
    
    // MARK: - Init
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.backgroundColor = .systemGray6
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - SetupUI
private extension LastMatchCell {
    private func setupUI() {
        setupLastMatchContainerView()
    }
    
    private func setupLastMatchContainerView() {
        contentView.addSubview(lastMatchContainerView)
        lastMatchContainerView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            lastMatchContainerView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 16),
            lastMatchContainerView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            lastMatchContainerView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            lastMatchContainerView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -16)
        ])
    }
}

class LastMatchContainerView: UIView {
    
    let gamePlace = UILabel.createCustomLabel(
        text: "Kufstein Arena",
        textColor: .label,
        fontSize: 15,
        fontWeight: .bold
    )
    
    let dateLabel = UILabel.createCustomLabel(
        text: "Sat, Nov 23, 2023",
        textColor: .label,
        fontSize: 14,
        fontWeight: .heavy
    )
    
    private let dateSeparator = createView(color: .separator)
    private let gameSeparator = createView(color: .separator)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .systemBackground.withAlphaComponent(0.6)
        layer.cornerRadius = 20
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override var intrinsicContentSize: CGSize {
        return CGSize(width: 200, height: 400)
    }
}

// MARK: - Setup
private extension LastMatchContainerView {
    private func setupUI() {
        setupLabels()
        setupSeparator()
    }
    
    private func setupLabels() {
        addSubview(dateLabel)
        addSubview(gamePlace)
        dateLabel.translatesAutoresizingMaskIntoConstraints = false
        gamePlace.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            dateLabel.centerYAnchor.constraint(equalTo: gamePlace.centerYAnchor),
            dateLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            gamePlace.topAnchor.constraint(equalTo: topAnchor, constant: 16),
            gamePlace.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16)
        ])
    }
    
    private func setupSeparator() {
        addSubview(dateSeparator)
        addSubview(gameSeparator)
        
        dateSeparator.translatesAutoresizingMaskIntoConstraints = false
        gameSeparator.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            gameSeparator.topAnchor.constraint(equalTo: gamePlace.bottomAnchor, constant: 4),
            gameSeparator.leadingAnchor.constraint(equalTo: gamePlace.leadingAnchor),
            gameSeparator.trailingAnchor.constraint(equalTo: gamePlace.trailingAnchor),
            gameSeparator.heightAnchor.constraint(equalToConstant: 1),
            
            dateSeparator.topAnchor.constraint(equalTo: dateLabel.bottomAnchor, constant: 4),
            dateSeparator.leadingAnchor.constraint(equalTo: dateLabel.leadingAnchor),
            dateSeparator.trailingAnchor.constraint(equalTo: dateLabel.trailingAnchor),
            dateSeparator.heightAnchor.constraint(equalToConstant: 1),
        ])
    }
}

