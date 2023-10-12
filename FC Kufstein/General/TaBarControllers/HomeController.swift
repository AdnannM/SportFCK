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
        tableView.register(HomeControllerCell.self, forCellReuseIdentifier: HomeControllerCell.cellID)
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
            tableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
        
        tableView.delegate = self
        tableView.dataSource = self
    }
}

// MARK: - TableViewDelegate and TableViewDataSource
extension HomeController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: HomeControllerCell.cellID, for: indexPath) as? HomeControllerCell else {
            return UITableViewCell()
        }
        
        cell.containerView.delegate = self
        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 300
    }
}

// MARK: - Action
extension HomeController {
    @objc private func didTapSettings() {
        let hostController = UIHostingController(rootView: SettingsSwiftUIView())
        present(hostController, animated: true)
    }
}

extension HomeController: ContainerViewDelegate {
    func didTapAllMatch(_ view: ContainerView) {
        self.navigationController?.pushViewController(AllMatchController(), animated: true)
    }
}
