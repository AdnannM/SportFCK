//
//  MatchController.swift
//  FC Kufstein
//
//  Created by Adnann Muratovic on 09.10.23.
//

import UIKit

enum MatchDataType: String {
    case KM = "KM"
    case oneB = "1b"
}


class MatchController: UIViewController {
    
    // MARK: - Properties
    var finishedMatches: [MetchInfo.KMData] = []
    var finishedMatchesJuniors: [MetchInfo.KMData] = []
    
    var reversedFinishedMatches: [MetchInfo.KMData] {
        return finishedMatches.reversed()
    }

    var reversedFinishedMatchesJuniors: [MetchInfo.KMData] {
        return finishedMatchesJuniors.reversed()
    }
    
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
            await withTaskGroup(of: Void.self) { group in
                group.addTask {
                    await self.fetchMatchData(for: .KM)
                }
                group.addTask {
                    await self.fetchMatchData(for: .oneB)
                }
                for await _ in group {} // Wait for all tasks to complete
            }
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
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
        
        segmentedControl.selectedSegmentIndex = 0
        
        NSLayoutConstraint.activate([
            segmentedControl.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            segmentedControl.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 8),
            segmentedControl.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -8),
        ])
        
        segmentedControl.addTarget(self, action: #selector(segmentedControlValueChanged(_:)), for: .valueChanged)
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
        if isFetchingData {
            return 10 // Adjust this based on your preference
        } else {
            if segmentedControl.selectedSegmentIndex == 0 {
                return finishedMatches.count
            } else {
                return finishedMatchesJuniors.count
            }
        }
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

            var matchData: MetchInfo.KMData?
            
            // Determine which array to use based on segmented control value
            if segmentedControl.selectedSegmentIndex == 0 {
                // Display KM data
                matchData = reversedFinishedMatches[indexPath.row]
            } else {
                // Display 1b data for FC Kufstein Juniors
                matchData = reversedFinishedMatchesJuniors[indexPath.row]
            }
            
            if let data = matchData {
                let viewModel = MatchViewMode(model: data)
                cell.configureCell(withViewModel: viewModel)
            }

            cell.separatorInset = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16)
            cell.isUserInteractionEnabled = false
            return cell
        }
    }


    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

// MARK: - Action
extension MatchController {
    // Update segmented control action to handle team selection
    @objc func segmentedControlValueChanged(_ sender: UISegmentedControl) {
        switch sender.selectedSegmentIndex {
        case 0:
            fetchDataAndUpdateTableView(for: .KM)
        case 1:
            fetchDataAndUpdateTableView(for: .oneB)
        default:
            break
        }
    }
    
    private func fetchDataAndUpdateTableView(for dataType: MatchDataType) {
        Task {
            await fetchMatchData(for: dataType)
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
}


// MARK: - Networking

extension MatchController {
    // Fetch and display finished matches in the table view
    func fetchMatchData(for dataType: MatchDataType) async {
        do {
            startShimmer() // Set isFetchingData to true before fetching data
            let matchInfo = try await ApiManager.shared.fetchMatchInfo()
            let currentDate = Date()
            
            let updatedMatches = filterMatches(matchInfo: matchInfo, for: dataType, currentDate: currentDate)
            
            updateMatches(for: dataType, updatedMatches: updatedMatches)
            reloadTableView()
        } catch {
            print("Error: \(error)")
        }
    }
    
    private func filterMatches(matchInfo: MetchInfo, for dataType: MatchDataType, currentDate: Date) -> [MetchInfo.KMData] {
        guard let items = matchInfo.plan[dataType.rawValue] else {
            print("No \(dataType.rawValue) data found")
            return []
        }
        
        return items.filter { item in
            let matchDate = Date(timeIntervalSince1970: TimeInterval(item.datum) / 1000)
            return matchDate < currentDate
        }
    }
    
    private func updateMatches(for dataType: MatchDataType, updatedMatches: [MetchInfo.KMData]) {
        switch dataType {
        case .KM:
            finishedMatches = updatedMatches
        case .oneB:
            finishedMatchesJuniors = updatedMatches
        }
    }
    
    private func reloadTableView() {
        DispatchQueue.main.async {
            self.stopShimmer()
            self.tableView.reloadData()
        }
    }
}




