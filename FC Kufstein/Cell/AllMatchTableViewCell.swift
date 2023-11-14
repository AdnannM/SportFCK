//
//  AllMatchTableViewCell.swift
//  FC Kufstein
//
//  Created by Adnann Muratovic on 14.11.23.
//

import UIKit

class AllMatchTableViewCell: UITableViewCell {
    
    // MARK: - Properties
    static let cellID = "AllMatchTableViewCell"
    
    var timer: Timer?
        
    // MARK: - Components
    let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd.MM.yyyy HH:mm:ss" // You can adjust the format as needed
        return formatter
    }()
    
    private lazy var containerView = AllMatchContainerView()
    
    // MARK: - LifeCycle
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

// MARK: - SetupUI
private extension AllMatchTableViewCell {
    private func setupUI() {
        setupContainerView()
    }
    
    private func setupContainerView() {
        contentView.addSubview(containerView)
        containerView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            containerView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            containerView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8),
            containerView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8),
            containerView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8),
        ])
    }
}

// MARK: - ConfigureCell
extension AllMatchTableViewCell {
   
    func configureCell(withViewModel viewModel: UpcommingMatchViewModel) {
        let date = Date(timeIntervalSince1970: TimeInterval(viewModel.model.datum / 1000))
        let dateFormatter = getDateFormatter("E, MMM dd, yyyy")
        
        containerView.gameLigaLabel.text = "\(viewModel.model.bewerbBezeichnung) | \(dateFormatter.string(from: date))"
        
        if let heimLogoURL = viewModel.heimLogoURL() {
            containerView.homeImageView.sd_setImage(with: heimLogoURL, placeholderImage: nil, options: .refreshCached)
        }
        
        if let gastLogoURL = viewModel.gastLogoURL() {
            containerView.guestImageView.sd_setImage(with: gastLogoURL, placeholderImage: nil, options: .refreshCached)
            
        }
        
        // Start timer to update labels
        startTimer(matchDate: date)
        
        containerView.dayLabel.text = ""
        containerView.minLabel.text = ""
        containerView.secLabel.text = ""
        
        containerView.gamePlaceLabel.text = viewModel.model.spielort
    }

    func startTimer(matchDate: Date) {
        timer?.invalidate() // Stop the timer if it's already running
        
        timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { [weak self] _ in
            guard let self = self else { return }
            
            let timeRemaining = self.timeRemainingUntilMatch(matchDate)
            
            if timeRemaining.days <= 0 && timeRemaining.hours <= 0 && timeRemaining.minutes <= 0 {
                // Stop the timer when remaining time is zero or negative
                self.timer?.invalidate()
            } else {
                self.containerView.dayLabel.text = "\(timeRemaining.days)"
                self.containerView.minLabel.text = "\(timeRemaining.hours)"
                self.containerView.secLabel.text = "\(timeRemaining.minutes)"
            }
        }
    }
    
    /// Helpers
    func getDateFormatter(_ format: String) -> DateFormatter {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        return dateFormatter
    }
    
    func formatDate(unixTimestamp: Int) -> String {
        let date = Date(timeIntervalSince1970: TimeInterval(unixTimestamp) / 1000)
        return dateFormatter.string(from: date)
    }
    
    func timeRemainingUntilMatch(_ matchDate: Date) -> (days: Int, hours: Int, minutes: Int) {
        let calendar = Calendar.current
        let components = calendar.dateComponents([.day, .hour, .minute], from: Date(), to: matchDate)

        if let days = components.day, let hours = components.hour, let minutes = components.minute {
            return (days, hours, minutes)
        }

        return (0, 0, 0)
    }
}
