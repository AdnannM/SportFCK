//
//  MatchController.swift
//  FC Kufstein
//
//  Created by Adnann Muratovic on 09.10.23.
//

import UIKit

class MatchController: UIViewController {
    
    // MARK: - Properties
    var finishedMatches: [MetchInfo.KMData] = []
    
    // MARK: - Components
    private let tableView: UITableView = {
        let tableView = UITableView()
        tableView.register(FinishedMatchTableCell.self, forCellReuseIdentifier: FinishedMatchTableCell.cellID)
        return tableView
    }()
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        fetchData()
    }
    
    /// Fetch Data
    private func fetchData() {
        Task {
            await fetchMatchData()
        }
    }
}

// MARK: - Setup
private extension MatchController {
    private func setupUI() {
        view.backgroundColor = .systemBackground
        title = "Spiele"
        
        setupTableView()
    }
    
    private func setupTableView() {
        view.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
        
        tableView.delegate = self
        tableView.dataSource = self
    }
}

// MARK: - TableViewDelegate & TableViewDataSoruce
extension MatchController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return finishedMatches.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: FinishedMatchTableCell.cellID,
            for: indexPath
        ) as? FinishedMatchTableCell else {
            return UITableViewCell()
        }
        
        // Reverse the order of items to display the last item first
        let matchData = finishedMatches.reversed()[indexPath.row]
        let viewModel = MatchViewMode(model: matchData)
        cell.configureCell(withViewModel: viewModel)
        
        cell.separatorInset = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16)
        cell.isUserInteractionEnabled = false
        return cell
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Abgeschlossene Spiele"
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}


// MARK: - Networking
extension MatchController {
    // Fetch and display finished matches in the table view
    func fetchMatchData() async {
        do {
//            startShimmer() // Set isFetchingData to true before fetching data
            let matchInfo = try await ApiManager.shared.fetchMatchInfo()
            let currentDate = Date()

            // Clear the existing array
            finishedMatches.removeAll()

            print("Match Info:")
            if let items = matchInfo.plan["KM"] {
                for item in items {
                    let matchDate = Date(timeIntervalSince1970: TimeInterval(item.datum) / 1000)
                    if matchDate < currentDate {
                        finishedMatches.append(item)
                    }
                }

                // Reload the table view to display finished matches
                DispatchQueue.main.async { [weak self] in
                    self?.tableView.reloadData()
//                    self?.stopShimmer() // Set isFetchingData to false after fetching and updating data
                }
            }
        } catch {
            print("Error: \(error)")
        }
    }
}



