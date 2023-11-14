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
    
    var isFetchingData: Bool = false
    private let refreshControl = UIRefreshControl()
    
    // MARK: - Components
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.register(AllMatchTableViewCell.self, forCellReuseIdentifier: AllMatchTableViewCell.cellID)
        tableView.register(ShimmerAllMatchTableViewCell.self, forCellReuseIdentifier: ShimmerAllMatchTableViewCell.cellID)
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
        refreshControl.endRefreshing()
    }
}

// MARK: - SetupUI
private extension AllMatchController {
    private func setupUI() {
        view.backgroundColor = .systemGray6
        title = "Alle Spiele"
        
        setupTableView()
        
        tableView.refreshControl = refreshControl
        refreshControl.addTarget(self, action: #selector(refreshData(_:)), for: .valueChanged)
            
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

// MARK: - UITableViewDelegate, UITableViewDataSource
extension AllMatchController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return isFetchingData ? 5 : upcommingMatchs.count
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
            
            let matchData = upcommingMatchs[indexPath.row]
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
}

// MARK: - Networking
extension AllMatchController {
    func fetchMatchData() async {
        do {
            
            startShimmer()
            let matchInfo = try await ApiManager.shared.fetchMatchInfo()
            let currentDate = Date()
            
            upcommingMatchs.removeAll()
            
            if let items = matchInfo.plan["KM"] {
                for item in items {
                    let matchDate = Date(timeIntervalSince1970: TimeInterval(item.datum) / 1000)
                    if matchDate >= currentDate {
                        upcommingMatchs.append(item)
                    }
                }
            }
            
            DispatchQueue.main.async {
                self.stopShimmer()
                self.tableView.reloadData()
            }
            
        } catch {
            print("Error: \(error)")
        }
    }
}

