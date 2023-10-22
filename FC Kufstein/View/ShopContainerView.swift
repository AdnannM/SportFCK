//
//  ShopContainerView.swift
//  FC Kufstein
//
//  Created by Adnann Muratovic on 19.10.23.
//

import UIKit

/*
    - TODO: add images in assets
    - TODO: update ui with data
    - TODO: query data with segment control
    - TODO: open link on safari view controller from cell use already created protocol SponsorsViewDelegate
    - TODO: add openItemURL to SponsorsViewDelegate
*/

class ShopContainerView: UIView {
    
    // MARK: - Components
    private let segmentedControl: UISegmentedControl = {
        let segControl = UISegmentedControl(items: ["Oberteile", "Jacken", "Unterteile", "Zubehör"])
        segControl.selectedSegmentIndex = 0
        segControl.selectedSegmentTintColor = .systemBlue.withAlphaComponent(0.5)
        segControl.backgroundImage(for: .normal, barMetrics: .default)
        segControl.backgroundColor = .systemBackground
        segControl.setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.black.withAlphaComponent(0.5)], for: .normal)
        return segControl
    }()
    
    private let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.sectionInset = UIEdgeInsets(top: 2, left: 8, bottom: 2, right: 8)
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.register(ShopCollectionViewCell.self, forCellWithReuseIdentifier: ShopCollectionViewCell.cellID)
        collectionView.backgroundColor = .systemGray5.withAlphaComponent(0.9)
        return collectionView
    }()
    
    // MARK: - Lifecycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

// MARK: - SetupUI
private extension ShopContainerView {
    private func setupUI() {
        backgroundColor = .systemGray5
        
        setupSegmentControl()
        setupCollectionView()
    }
    
    private func setupSegmentControl() {
        addSubview(segmentedControl)
        segmentedControl.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            segmentedControl.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 8),
            segmentedControl.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 8),
            segmentedControl.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -8),
        ])
        
        segmentedControl.addTarget(self, action: #selector(didTapSegmentControl(_:)), for: .valueChanged)
    }
    
    private func setupCollectionView() {
        addSubview(collectionView)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalToSystemSpacingBelow: segmentedControl.bottomAnchor, multiplier: 1),
            collectionView.leadingAnchor.constraint(equalTo: leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
        
        collectionView.delegate = self
        collectionView.dataSource = self
    }
}

// MARK: - CollectionViewDataSource and CollectionViewDelegate
extension ShopContainerView: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 15
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ShopCollectionViewCell.cellID, for: indexPath) as? ShopCollectionViewCell else {
            return UICollectionViewCell()
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 200, height: 260)
    }
}
    
// MARK: - Action
extension ShopContainerView {
    @objc private func didTapSegmentControl(_ sender: UISegmentedControl) {
        switch segmentedControl.selectedSegmentIndex {
        case 0:
            print("1")
        case 1:
            print("2")
        case 2:
            print("3")
        case 3:
            print("4")
        case 4:
            print("5")
        default:
            break
        }
    }
}

