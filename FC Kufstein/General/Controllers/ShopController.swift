//
//  ShopController.swift
//  FC Kufstein
//
//  Created by Adnann Muratovic on 12.10.23.
//

import UIKit

class ShopController: UIViewController {
    
    // MARK: - Properties
    private let shopContainerView = ShopContainerView()
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
}

// MARK: - SetupUI
private extension ShopController {
    private func setupUI() {
        title = "Shop"
        view.backgroundColor = .systemGray6
        shopContainerView.delegate = self
        setupShopContainerView()
    }
    
    private func setupShopContainerView() {
        view.addSubview(shopContainerView)
        shopContainerView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            shopContainerView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            shopContainerView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            shopContainerView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            shopContainerView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
        ])
    }
}

// MARK: - ShopContainerViewDelegate
extension ShopController: ShopContainerViewDelegate {
    func openShopURL(_ url: URL) {
        presentSafariController(withURL: url)
    }
}
