//
//  TableContainer.swift
//  FC Kufstein
//
//  Created by Adnann Muratovic on 09.10.23.
//

import UIKit

final class TableViewController: UIViewController {
    
    // MARK: - Properties
    var mainTeamEntries: [Entry] = []
    var juniorTeamEntries: [Entry] = []
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
    
    private let tableTitleView = ResultMatchTitleView()
    
    private let tableView: UITableView = {
        let tableView = UITableView()
        tableView.register(TableViewCell.self, forCellReuseIdentifier: TableViewCell.cellID)
        tableView.register(ShimmerTableViewCell.self, forCellReuseIdentifier: ShimmerTableViewCell.cellID)
        return tableView
    }()
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        addPullToRefresh()
        fetchData(for: .mainTeam)
        fetchData(for: .juniors)
    }
    
    func startShimmer() {
        isFetchingData = true
        tableView.reloadData()
    }
    
    func stopShimmer() {
        isFetchingData = false
        tableView.reloadData()
    }
    
    private func addPullToRefresh() {
        tableView.addPullToRefresh { [weak self] in
            self?.refreshData()
        }
    }
}


// MARK: - Setup
private extension TableViewController {
    private func setupUI() {
        view.backgroundColor = .systemGray5
        navigationController?.navigationBar.prefersLargeTitles = true
        setupSegmentControl()
        setupResutlTitleView()
        setupTableView()
    }
    
    private func setupSegmentControl() {
        view.addSubview(segmentedControl)
        
        segmentedControl.selectedSegmentIndex = 0
        segmentedControl.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            segmentedControl.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            segmentedControl.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 8),
            segmentedControl.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -8),
        ])
        
        segmentedControl.addTarget(self, action: #selector(segmentedControlValueChanged(_:)), for: .valueChanged)
    }
    
    private func setupResutlTitleView() {
        view.addSubview(tableTitleView)
        
        tableTitleView.topAnchor.constraint(equalTo: segmentedControl.bottomAnchor, constant: 8).isActive = true
        tableTitleView.leadingAnchor.constraint(equalTo: segmentedControl.leadingAnchor, constant: 8).isActive = true
        tableTitleView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -8).isActive = true
        tableTitleView.heightAnchor.constraint(equalToConstant: 20).isActive = true
    }
    
    private func setupTableView() {
        view.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: tableTitleView.bottomAnchor, constant: 8),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
        
        tableView.delegate = self
        tableView.dataSource = self
    }
}


// MARK: - TableViewDelegate and TableViewDataSource
extension TableViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if isFetchingData {
            // Return the number of shimmer cells you want to display
            return 10 // Adjust this based on your preference
        } else {
            if segmentedControl.selectedSegmentIndex == 0 {
                return mainTeamEntries.count
            } else {
                return juniorTeamEntries.count
            }
        }
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if isFetchingData {
            return tableView.dequeueReusableCell(withIdentifier: ShimmerTableViewCell.cellID, for: indexPath)
        } else {
            // Normal cell configuration
            guard let cell = tableView.dequeueReusableCell(
                withIdentifier: TableViewCell.cellID,
                for: indexPath
            ) as? TableViewCell else {
                return UITableViewCell()
            }
            
            var entry: Entry
            if segmentedControl.selectedSegmentIndex == 0 {
                entry = mainTeamEntries[indexPath.row]
            } else {
                entry = juniorTeamEntries[indexPath.row]
            }
            
            let viewModel = TableEntryViewModel(entry: entry)
            cell.configure(with: viewModel)
            
            cell.separatorInset = UIEdgeInsets(top: 0, left: 8, bottom: 0, right: 8)
            cell.isUserInteractionEnabled = false
            
            return cell
        }
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

// MARK: - Action
extension TableViewController {
    @objc private func segmentedControlValueChanged(_ sender: UISegmentedControl) {
        switch sender.selectedSegmentIndex {
        case 0:
            // Fetch and display data for the main team
            fetchData(for: .mainTeam)
        case 1:
            fetchData(for: .juniors)
        default:
            break
        }
    }
    
    @objc private func refreshData() {
        fetchData(for: segmentedControl.selectedSegmentIndex == 0 ? .mainTeam : .juniors)
        tableView.reloadData()
        self.tableView.refreshControl?.endRefreshing()
    }
}



// MARK: - Networking
extension TableViewController {
    // MARK: - Function to fetch and print table data for the main team
    private func fetchData(for teamType: TeamType) {
        Task {
            do {
                startShimmer()
                let tableInfo = try await fetchTableInfo(for: teamType)
                updateEntries(for: teamType, with: tableInfo.eintraege)
                stopShimmer()
            } catch {
                print("Error fetching \(teamType) team table data: \(error)")
            }
        }
    }
    
    private func fetchTableInfo(for teamType: TeamType) async throws -> Table {
        switch teamType {
        case .mainTeam:
            return try await ApiManager.shared.fetchMainTeamTableInfo().tabellen.HEIM
        case .juniors:
            return try await ApiManager.shared.fetchJuniorsTableInfo().tabellen.HEIM
        }
    }
    
    private func updateEntries(for teamType: TeamType, with newEntries: [Entry]) {
        switch teamType {
        case .mainTeam:
            mainTeamEntries = newEntries
        case .juniors:
            juniorTeamEntries = newEntries
        }
        tableView.reloadData()
    }
}
