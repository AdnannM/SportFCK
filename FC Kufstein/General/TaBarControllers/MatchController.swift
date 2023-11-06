//
//  MatchController.swift
//  FC Kufstein
//
//  Created by Adnann Muratovic on 09.10.23.
//

import UIKit

class MatchController: UIViewController {
    
    // MARK: - Properties
    private var lastGameInfo = [LastGameInfo]()
    
    // MARK: - Components
    private let tableView: UITableView = {
        let tableView = UITableView()
        tableView.register(LastMatchCell.self, forCellReuseIdentifier: LastMatchCell.cellID)
        tableView.backgroundColor = .systemGray6
        return tableView
    }()
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
}

// MARK: - Setup
private extension MatchController {
    private func setupUI() {
        view.backgroundColor = .systemGray5
        title = "Match"
        
        setupTableView()
        
        Task {
            await fetchLastMatchTest()
        }
    }
    
    private func setupTableView() {
        view.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
        
        tableView.delegate = self
        tableView.dataSource = self
    }
}

// MARK: - TableViewDelegate and TableViewDataSource
extension MatchController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return lastGameInfo.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: LastMatchCell.cellID,
            for: indexPath
        ) as? LastMatchCell else {
            return UITableViewCell()
        }
        
        
        let modelData = lastGameInfo[indexPath.row]
        let viewModel = LastGameInfoViewModel(model: modelData)
        
        cell.configureCell(withViewModel: viewModel)
        cell.separatorInset = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

// MARK: - FetchData
extension MatchController {
    func fetchLastMatchTest() async {
        do {
            let lastGameInfo = try await ApiManager.shared.fetchLastGameInfo()
            self.lastGameInfo = [lastGameInfo] // Assuming you want to display a single match
            print(lastGameInfo.letztes.datum)
            
            tableView.reloadData()
        } catch {
            print("Error: \(error)")
        }
    }
}




