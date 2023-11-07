//
//  FinishedMatchTableCell.swift
//  FC Kufstein
//
//  Created by Adnann Muratovic on 07.11.23.
//

import UIKit

class FinishedMatchTableCell: UITableViewCell {
    
    // MARK: - Properties
    static let cellID = "FinishedMatchTableCell"
    
    // MARK: - Component
    private let finishedMatchView = FinishedMatchView()
    
    // MARK: - LifeCycle
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - Setup
private extension FinishedMatchTableCell {
    private func setupUI() {
        setupFinishedMatchView()
    }
    
    private func setupFinishedMatchView() {
        contentView.addSubview(finishedMatchView)
        finishedMatchView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            finishedMatchView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            finishedMatchView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8),
            finishedMatchView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8),
            finishedMatchView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8)
        ])
    }
}

// MARK: - Confifure Cell
extension FinishedMatchTableCell {
    func configureCell(withViewModel viewModel: MatchViewMode) {
        let date = Date(timeIntervalSince1970: TimeInterval(viewModel.model.datum / 1000))
        let dateFormatter = getDateFormatter("E, MMM dd, yyyy | HH:mm")
        
        finishedMatchView.gameLigaLabel.text = "\(viewModel.model.bewerbBezeichnung) | \(dateFormatter.string(from: date))"
        
        if let heimLogoURL = viewModel.heimLogoURL() {
            finishedMatchView.homeImageView.sd_setImage(with: heimLogoURL, placeholderImage: nil, options: .refreshCached)
        }
        
        if let gastLogoURL = viewModel.gastLogoURL() {
            finishedMatchView.guestImageView.sd_setImage(with: gastLogoURL, placeholderImage: nil, options: .refreshCached)
            
        }
        
        finishedMatchView.halfTimeScore.text = viewModel.model.ergebnis
        finishedMatchView.gamePlaceLabel.text = viewModel.model.spielort
        
        finishedMatchView.homeScoreLabel.text = viewModel.model.heimTore
        finishedMatchView.guestScoreLabel.text = viewModel.model.gastTore
    }
    
    /// Helpers
    func getDateFormatter(_ format: String) -> DateFormatter {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        return dateFormatter
    }
}
