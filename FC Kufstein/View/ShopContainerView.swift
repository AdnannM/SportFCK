//
//  ShopContainerView.swift
//  FC Kufstein
//
//  Created by Adnann Muratovic on 19.10.23.
//

import UIKit

protocol ShopContainerViewDelegate: AnyObject {
    func openShopURL(_ url: URL)
}

class ShopContainerView: UIView {
    
    // MARK: - Properties
    private var shopModelData = ShopDataModel.ShopModel()
    
    weak var delegate: ShopContainerViewDelegate?
    
    // Create separate arrays for each category
    private var oberteileData: [ShopDataModel] = []
    private var jackenData: [ShopDataModel] = []
    private var unterteileData: [ShopDataModel] = []
    private var zubehörData: [ShopDataModel] = []
    
    // Store filtered data here
    private var filteredShopData: [ShopDataModel] = []
        
    // MARK: - Components
    private let segmentedControl: UISegmentedControl = {
        let segControl = UISegmentedControl(items: ["Oberteile", "Jacken", "Unterteile", "Zubehör"])
        segControl.selectedSegmentIndex = 0
        segControl.selectedSegmentTintColor = .systemBlue.withAlphaComponent(0.5)
        segControl.backgroundImage(for: .normal, barMetrics: .default)
        segControl.backgroundColor = .systemBackground
        segControl.setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.label], for: .normal)
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
        
        // In your setupUI() function or in your init method
        oberteileData = shopModelData.model.filter { $0.category == "oberteile" }
        jackenData = shopModelData.model.filter { $0.category == "jacken" }
        unterteileData = shopModelData.model.filter { $0.category == "unterteile" }
        zubehörData = shopModelData.model.filter { $0.category == "zubehör" }
        
        // Select the initial category (e.g., "oberteile")
        segmentedControl.selectedSegmentIndex = 0
        
        // Trigger the segment control action manually
        didTapSegmentControl(segmentedControl)

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
        return filteredShopData.count // Use filteredShopData instead of shopModelData.model
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ShopCollectionViewCell.cellID, for: indexPath) as? ShopCollectionViewCell else {
            return UICollectionViewCell()
        }
        let model = filteredShopData[indexPath.row] // Use filteredShopData instead of shopModelData.model
        cell.configure(withModel: model)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 180, height: 220)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        // Set the vertical spacing between items
        return 20.0  // Adjust this value as needed
    }
        
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let model = filteredShopData[indexPath.row]
        delegate?.openShopURL(model.url)
    }
}

    
// MARK: - Action
extension ShopContainerView {
    @objc private func didTapSegmentControl(_ sender: UISegmentedControl) {
        let selectedCategoryIndex = sender.selectedSegmentIndex
        
        switch selectedCategoryIndex {
        case 0:
            filteredShopData = oberteileData
        case 1:
            filteredShopData = jackenData
        case 2:
            filteredShopData = unterteileData
        case 3:
            filteredShopData = zubehörData
        default:
            break
        }
        
        // Reload the collection view with the filtered data
        collectionView.reloadData()
    }
}


