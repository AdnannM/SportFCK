//
//  HomeViewController.swift
//  FC Kufstein
//
//  Created by Adnann Muratovic on 09.10.23.
//

import UIKit
import SwiftUI

class HomeController: UIViewController {
    
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

// MARK: - SetupUI
private extension HomeController {
    private func setupUI() {
        view.backgroundColor = .systemGray5
        title = "Feed"
        setupRightBarButton()
        setupTableView()
    }
    
    // header
    private func setupRightBarButton() {
        // Create an SF Symbol image
        let settingsSymbol = UIImage(systemName: "gear")
        
        // Create a UIBarButtonItem with the SF Symbol image
        let settingsButton = UIBarButtonItem(
            image: settingsSymbol,
            style: .plain,
            target: self,
            action: #selector(didTapSettings)
        )
        
        // Set the UIBarButtonItem as the rightBarButtonItem
        navigationItem.rightBarButtonItem = settingsButton
        navigationController?.navigationBar.tintColor = .label
    }
    
    // main
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
extension HomeController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 20
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.textLabel?.text = "Text"
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

// MARK: - Action
extension HomeController {
    @objc private func didTapSettings() {
        let hostController = UIHostingController(rootView: SettingsSwiftUIView())
        present(hostController, animated: true)
    }
}
