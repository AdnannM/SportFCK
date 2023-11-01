//
//  VideoController.swift
//  FC Kufstein
//
//  Created by Adnann Muratovic on 12.10.23.
//

import UIKit

class VideoController: UIViewController {
    
    // MARK: - Components
    private let allVideoContainerView = AllVideosContainerView()
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
}

// MARK: - SetupUI
private extension VideoController {
    private func setupUI() {
        title = "FC Kufstein TV"
        view.backgroundColor = .systemGray6
        
        setupAllVideoContainerView()
    }
    
    private func setupAllVideoContainerView() {
        view.addSubview(allVideoContainerView)
        allVideoContainerView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            allVideoContainerView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            allVideoContainerView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            allVideoContainerView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            allVideoContainerView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
}
