//
//  NextGenerationController.swift
//  FC Kufstein
//
//  Created by Adnann Muratovic on 20.11.23.
//

import UIKit

enum NextGenMatchType: String {
    case u16A = "U16 A"
    case u16B = "U16 B"
    case u14 = "U14"
    case u13 = "U13 A"
}

class NextGenerationController: UIViewController {
    
    // MARK: - Properties
    var finishedMatchesU16A: [MetchInfo.KMData] = []
    var finishedMatchesU16B: [MetchInfo.KMData] = []
    var finishedMatchesU14: [MetchInfo.KMData] = []
    var finishedMatchesU13: [MetchInfo.KMData] = []
    
    var reversedFinishedMatchesU16A: [MetchInfo.KMData] {
        return finishedMatchesU16A.reversed()
    }
    
    var reversedFinishedMatchesU16B: [MetchInfo.KMData] {
        return finishedMatchesU16B.reversed()
    }
    
    var reversedFinishedMatchesU14: [MetchInfo.KMData] {
        return finishedMatchesU14.reversed()
    }
    
    var reversedFinishedMatchesU13: [MetchInfo.KMData] {
        return finishedMatchesU13.reversed()
    }
    
    var isFetchingData: Bool = false
    
    // MARK: - Components
    private let segmentedControl: UISegmentedControl = {
        let segControl = UISegmentedControl(items: ["FCK U16A", "FCK U16B", "FCK U14", "FCK U13"])
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
    
    private func fetchData() {
        Task {
            await withTaskGroup(of: Void.self) { group in
                group.addTask {
                    await self.fetchMatchData(for: .u16A)
                }
                group.addTask {
                    await self.fetchMatchData(for: .u16B)
                }
                group.addTask {
                    await self.fetchMatchData(for: .u14)
                }
                group.addTask {
                    await self.fetchMatchData(for: .u13)
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
private extension NextGenerationController {
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
extension NextGenerationController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if isFetchingData {
            return 7 // Adjust this based on your preference
        } else {
            if segmentedControl.selectedSegmentIndex == 0 {
                return finishedMatchesU16A.count
            } else if segmentedControl.selectedSegmentIndex == 1 {
                return finishedMatchesU16B.count
            } else if segmentedControl.selectedSegmentIndex == 2 {
                return finishedMatchesU14.count
            } else {
                return finishedMatchesU13.count
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
                matchData = reversedFinishedMatchesU16A[indexPath.row]
            } else if segmentedControl.selectedSegmentIndex == 1 {
                // Display 1b data for FC Kufstein Juniors
                matchData = reversedFinishedMatchesU16B[indexPath.row]
            } else if segmentedControl.selectedSegmentIndex == 2 {
                matchData = reversedFinishedMatchesU14[indexPath.row]
            } else {
                matchData = reversedFinishedMatchesU13[indexPath.row]
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

// MARK: - Networking

extension NextGenerationController {
    // Fetch and display finished matches in the table view
    func fetchMatchData(for dataType: NextGenMatchType) async {
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
    
    private func filterMatches(matchInfo: MetchInfo, for dataType: NextGenMatchType, currentDate: Date) -> [MetchInfo.KMData] {
        guard let items = matchInfo.plan[dataType.rawValue] else {
            print("No \(dataType.rawValue) data found")
            return []
        }
        
        return items.filter { item in
            let matchDate = Date(timeIntervalSince1970: TimeInterval(item.datum) / 1000)
            return matchDate < currentDate
        }
    }
    
    private func updateMatches(for dataType: NextGenMatchType, updatedMatches: [MetchInfo.KMData]) {
        switch dataType {
        case .u16A:
            finishedMatchesU16A = updatedMatches
        case .u16B:
            finishedMatchesU16B = updatedMatches
        case .u14:
            finishedMatchesU14 = updatedMatches
        case .u13:
            finishedMatchesU13 = updatedMatches
        }
    }
    
    private func reloadTableView() {
        DispatchQueue.main.async {
            self.stopShimmer()
            self.tableView.reloadData()
        }
    }
}

// MARK: - Action
extension NextGenerationController {
    // Update segmented control action to handle team selection
    @objc func segmentedControlValueChanged(_ sender: UISegmentedControl) {
        switch sender.selectedSegmentIndex {
        case 0:
            fetchDataAndUpdateTableView(for: .u16A)
        case 1:
            fetchDataAndUpdateTableView(for: .u16B)
        case 2:
            fetchDataAndUpdateTableView(for: .u14)
        case 3:
            fetchDataAndUpdateTableView(for: .u13)
        default:
            break
        }
    }
    
    private func fetchDataAndUpdateTableView(for dataType: NextGenMatchType) {
        Task {
            await fetchMatchData(for: dataType)
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
}
