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

// MARK: - Configure cell
extension LastMatchCell {
    func configureCell(withViewModel viewModel: LastGameInfoViewModel) {
        let date = Date(timeIntervalSince1970: TimeInterval(viewModel.model.letztes.datum / 1000))
        lastMatchContainerView.gamePlace.text = viewModel.model.letztes.spielort
        
        let dateFormatter = getDateFormatter("E, MMM dd, yyyy")
        lastMatchContainerView.dateLabel.text = dateFormatter.string(from: date)
        
        if let heimLogoURL = viewModel.heimLogoURL() {
            lastMatchContainerView.homeImageView.sd_setImage(with: heimLogoURL, placeholderImage: nil, options: .refreshCached)
        }
        
        if let gastLogoURL = viewModel.gastLogoURL() {
            lastMatchContainerView.guestImageView.sd_setImage(with: gastLogoURL, placeholderImage: nil, options: .refreshCached)
        }
        
        // Convert scores to integers if they are strings
        if let homeScore = Int(viewModel.model.letztes.heimTore), let guestScore = Int(viewModel.model.letztes.gastTore) {
            lastMatchContainerView.homeScoreLabel.text = viewModel.model.letztes.heimTore
            lastMatchContainerView.guestScoreLabel.text = viewModel.model.letztes.gastTore
            
            // Determine which score is higher and set its label to red
            if homeScore > guestScore {
                lastMatchContainerView.homeScoreLabel.textColor = .red
                lastMatchContainerView.guestScoreLabel.textColor = .label
            } else if homeScore < guestScore {
                lastMatchContainerView.homeScoreLabel.textColor = .label
                lastMatchContainerView.guestScoreLabel.textColor = .red
            } else {
                // Scores are equal, set both to black (or another color of your choice)
                lastMatchContainerView.homeScoreLabel.textColor = .label
                lastMatchContainerView.guestScoreLabel.textColor = .label
            }
        }
    }
    
    /// Helpers
    func getDateFormatter(_ format: String) -> DateFormatter {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        return dateFormatter
    }
}



