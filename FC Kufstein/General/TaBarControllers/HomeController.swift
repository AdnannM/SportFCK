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
    
    private let shopButton = CustomButton(
        title: "Shop Now",
        hasBackground: true,
        fontSize: .med
    )
    
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
        setupShopButton()
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
    
    private func setupShopButton() {
        view.addSubview(shopButton)
        shopButton.translatesAutoresizingMaskIntoConstraints = false
        shopButton.titleLabel?.adjustsFontSizeToFitWidth = true
        shopButton.titleLabel?.minimumScaleFactor = 0.5
        shopButton.layer.cornerRadius = 25
        
        NSLayoutConstraint.activate([
            shopButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -8),
            shopButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -16),
            shopButton.widthAnchor.constraint(equalToConstant: 140),
            shopButton.heightAnchor.constraint(equalToConstant: 50)
        ])
        
        shopButton.addTarget(self, action: #selector(didTapShopButton), for: .touchUpInside)
    }
}

// MARK: - TableViewDelegate and TableViewDataSource
extension HomeController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
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
        return 250
    }
}

// MARK: - Action
extension HomeController {
    @objc private func didTapSettings() {
        let hostController = UIHostingController(rootView: SettingsSwiftUIView())
        present(hostController, animated: true)
    }
    
    @objc private func didTapShopButton() {
        self.navigationController?.pushViewController(ShopController(), animated: true)
    }
}

// MARK: - ContainerViewDelegate
extension HomeController: ContainerViewDelegate {
    func didTapAllMatch(_ view: ContainerView) {
        self.navigationController?.pushViewController(AllMatchController(), animated: true)
    }
}



