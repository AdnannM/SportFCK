//
//  TableContainer.swift
//  FC Kufstein
//
//  Created by Adnann Muratovic on 09.10.23.
//

import UIKit

class TableViewController: UIViewController {
    
    // MARK: - Components
    private let tableView: UITableView = {
        let tableView = UITableView()
        return tableView
    }()
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
}


// MARK: - Setup
private extension TableViewController {
    private func setupUI() {
        view.backgroundColor = .systemGray5
        title = "Table"
        
        setupTableView()
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
extension TableViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 20
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.textLabel?.text = "Testing ✅"
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
