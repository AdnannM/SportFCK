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
    var isFetchingData: Bool = false
    
    // MARK: - Components
    private let segmentedControl: UISegmentedControl = {
        let segControl = UISegmentedControl(items: ["FC Kufstein", "FC Kufstein 1b"])
        segControl.selectedSegmentIndex = 0
        segControl.selectedSegmentTintColor = .systemBlue.withAlphaComponent(0.5)
        segControl.backgroundImage(for: .normal, barMetrics: .default)
        segControl.backgroundColor = .systemBackground
        segControl.setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.label], for: .normal)
        return segControl
    }()
    
    private let tableView: UITableView = {
        let tableView = UITableView()
        tableView.register(FinishedMatchTableCell.self, forCellReuseIdentifier: FinishedMatchTableCell.cellID)
        tableView.register(ShimmerFinishedMatchTableCell.self, forCellReuseIdentifier: ShimmerFinishedMatchTableCell.cellID)
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
    
    func startShimmer() {
        isFetchingData = true
        tableView.reloadData()
    }
    
    func stopShimmer() {
        isFetchingData = false
        tableView.reloadData()
    }
}

// MARK: - Setup
private extension MatchController {
    private func setupUI() {
        view.backgroundColor = .systemGray5
        navigationController?.navigationBar.prefersLargeTitles = true
        
        setupSegmentControl()
        setupTableView()
    }
    
    private func setupSegmentControl() {
        view.addSubview(segmentedControl)
        segmentedControl.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            segmentedControl.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            segmentedControl.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 8),
            segmentedControl.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -8),
        ])
        
//        segmentedControl.addTarget(self, action: #selector(segmentedControlValueChanged(_:)), for: .valueChanged)
    }
    
    private func setupTableView() {
        view.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: segmentedControl.bottomAnchor, constant: 8),
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
        return isFetchingData ? 7 : finishedMatches.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if isFetchingData {
            return tableView.dequeueReusableCell(withIdentifier: ShimmerFinishedMatchTableCell.cellID, for: indexPath)
        } else {
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
            startShimmer() // Set isFetchingData to true before fetching data
            let matchInfo = try await ApiManager.shared.fetchMatchInfo()
            let currentDate = Date()
            
            finishedMatches.removeAll()
            
            print("Match Info:")
            if let items = matchInfo.plan["KM"] {
                for item in items {
                    let matchDate = Date(timeIntervalSince1970: TimeInterval(item.datum) / 1000)
                    if matchDate < currentDate {
                        finishedMatches.append(item)
                    }
                }
            }
            
            // Reload the table view to display finished matches after the delay
            DispatchQueue.main.async {
                self.tableView.reloadData()
                self.stopShimmer()
            }
        } catch {
            print("Error: \(error)")
        }
    }
}



