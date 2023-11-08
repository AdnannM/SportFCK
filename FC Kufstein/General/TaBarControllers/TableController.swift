//
//  TableContainer.swift
//  FC Kufstein
//
//  Created by Adnann Muratovic on 09.10.23.
//

import UIKit

class TableViewController: UIViewController {
    
    // MARK: - Properties
    
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
        navigationController?.navigationBar.prefersLargeTitles = true
        setupSegmentControl()
        setupResutlTitleView()
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
        return 20
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: TableViewCell.cellID,
            for: indexPath
        ) as? TableViewCell else {
            return UITableViewCell()
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}







