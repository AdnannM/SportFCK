//
//  AllMatchController.swift
//  FC Kufstein
//
//  Created by Adnann Muratovic on 11.10.23.
//

import UIKit

class AllMatchController: UIViewController {
    
    // MARK: - Properties
    var upcommingMatchs: [MetchInfo.KMData] = []
    var upcommingMatchsJuniors: [MetchInfo.KMData] = []
    
    var isFetchingData: Bool = false
    private let refreshControl = UIRefreshControl()
    
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
    
    // MARK: - Components
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.register(AllMatchTableViewCell.self, forCellReuseIdentifier: AllMatchTableViewCell.cellID)
        tableView.register(ShimmerAllMatchTableViewCell.self, forCellReuseIdentifier: ShimmerAllMatchTableViewCell.cellID)
        return tableView
    }()
    
    // MARK: - Lifecycle
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        fetchData()
    }

    private func fetchData() {
        Task {
            await fetchMatchData(for: .KM) // Fetch initial data for KM
            await fetchMatchData(for: .oneB) // Fetch initial data for 1b
        }
    }

    
    func startShimmer() {
        isFetchingData = true
        tableView.reloadData()
    }
    
    func stopShimmer() {
        isFetchingData = false
        tableView.reloadData()
        refreshControl.endRefreshing()
    }
}

// MARK: - SetupUI
private extension AllMatchController {
    private func setupUI() {
        view.backgroundColor = .systemGray6
        title = "Alle Spiele"
        
        pullToRefrash()
        setupSegmentControl()
        setupTableView()
    }
    
    private func pullToRefrash() {
        tableView.refreshControl = refreshControl
        refreshControl.addTarget(self, action: #selector(refreshData(_:)), for: .valueChanged)
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
            tableView.topAnchor.constraint(equalTo: segmentedControl.bottomAnchor, constant: 4),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
        
        tableView.delegate = self
        tableView.dataSource = self
    }
}

// MARK: - UITableViewDelegate, UITableViewDataSource
extension AllMatchController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if isFetchingData {
            return 6 // Adjust this based on your preference
        } else {
            if segmentedControl.selectedSegmentIndex == 0 {
                return upcommingMatchs.count
            } else {
                return upcommingMatchsJuniors.count
            }
        }

    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if isFetchingData {
            return tableView.dequeueReusableCell(withIdentifier: ShimmerAllMatchTableViewCell.cellID, for: indexPath)
        } else {
            guard let cell = tableView.dequeueReusableCell(
                withIdentifier: AllMatchTableViewCell.cellID,
                for: indexPath
            ) as? AllMatchTableViewCell else {
                return UITableViewCell()
            }
            
            var matchData: MetchInfo.KMData
            
            if segmentedControl.selectedSegmentIndex == 0 {
                // Display data for FC Kufstein
                matchData = upcommingMatchs[indexPath.row]
            } else {
                // Display data for FC Kufstein Juniors
                matchData = upcommingMatchsJuniors[indexPath.row]
            }
            
            let viewModel = UpcommingMatchViewModel(model: matchData)
            cell.isUserInteractionEnabled = false
            cell.configureCell(withViewModel: viewModel)
            
            return cell
        }
    }

    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

// MARK: - Action
extension AllMatchController {
    @objc private func refreshData(_ sender: Any) {
        fetchData()
    }
    
    @objc func segmentedControlValueChanged(_ sender: UISegmentedControl) {
        fetchDataAndUpdateTableView(for: sender.selectedSegmentIndex == 0 ? .KM : .oneB)
    }
}

// MARK: - Networking
extension AllMatchController {
    func fetchMatchData(for dataType: MatchDataType) async {
        do {
            startShimmer()
            let matchInfo = try await ApiManager.shared.fetchMatchInfo()
            let currentDate = Date()
            
            var updatedMatches: [MetchInfo.KMData] = []
            
            if let items = matchInfo.plan[dataType.rawValue] {
                for item in items {
                    let matchDate = Date(timeIntervalSince1970: TimeInterval(item.datum) / 1000)
                    if matchDate >= currentDate {
                        updatedMatches.append(item)
                    }
                }
            }
            
            if dataType == .KM {
                upcommingMatchs = updatedMatches
            } else if dataType == .oneB {
                upcommingMatchsJuniors = updatedMatches
            }
            
            DispatchQueue.main.async {
                self.stopShimmer()
                self.tableView.reloadData()
            }
        } catch {
            print("Error: \(error)")
        }
    }
    
    private func fetchDataAndUpdateTableView(for dataType: MatchDataType) {
        Task {
            await fetchMatchData(for: dataType)
        }
    }
}

