//
//  HomeViewController.swift
//  FC Kufstein
//
//  Created by Adnann Muratovic on 09.10.23.
//

import UIKit
import SwiftUI

class HomeController: UIViewController {
    
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
    }
    
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

}

// MARK: - Action
extension HomeController {
    @objc private func didTapSettings() {
        let hostController = UIHostingController(rootView: SettingsSwiftUIView())
        present(hostController, animated: true)
    }
}
