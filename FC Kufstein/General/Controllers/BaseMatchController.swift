//
//  BaseMatchController.swift
//  FC Kufstein
//
//  Created by Adnann Muratovic on 20.11.23.
//

import UIKit

enum MatchDataType: String {
    case KM = "KM"
    case oneB = "1b"
}

class BaseMatchController: UIViewController {
    
    var finishedMatches: [MetchInfo.KMData] = []
    var finishedMatchesJuniors: [MetchInfo.KMData] = []
    
    var reversedFinishedMatches: [MetchInfo.KMData] {
        return finishedMatches.reversed()
    }
    
    var reversedFinishedMatchesJuniors: [MetchInfo.KMData] {
        return finishedMatchesJuniors.reversed()
    }
    
    var isFetchingData: Bool = false
    
    
    
    let segmentedControl: UISegmentedControl = {
        let segControl = UISegmentedControl(items: ["FC Kufstein", "FC Kufstein 1b"])
        segControl.selectedSegmentIndex = 0
        segControl.selectedSegmentTintColor = .systemBlue.withAlphaComponent(0.5)
        segControl.backgroundImage(for: .normal, barMetrics: .default)
        segControl.backgroundColor = .systemBackground
        segControl.setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.label], for: .normal)
        return segControl
    }()
    
    let tableView: UITableView = {
        let tableView = UITableView()
        tableView.register(FinishedMatchTableCell.self, forCellReuseIdentifier: FinishedMatchTableCell.cellID)
        tableView.register(ShimmerFinishedMatchTableCell.self, forCellReuseIdentifier: ShimmerFinishedMatchTableCell.cellID)
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        fetchData()
    }

    func fetchData() {
        fatalError("fetchData() must be overridden")
    }
    
    func startShimmer() {
        isFetchingData = true
        tableView.reloadData()
    }
    
    func stopShimmer() {
        isFetchingData = false
        tableView.reloadData()
    }
    
    func setupUI() {
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
    
    @objc func segmentedControlValueChanged(_ sender: UISegmentedControl) {
        fatalError("segmentedControlValueChanged(_: ) must be overridden")
    }
}

extension BaseMatchController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        fatalError("tableView(_:numberOfRowsInSection:) must be overridden")
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        fatalError("tableView(_:cellForRowAt:) must be overridden")
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
