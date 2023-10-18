//
//  SponsorsController.swift
//  FC Kufstein
//
//  Created by Adnann Muratovic on 13.10.23.
//

import UIKit

class SponsorsController: UIViewController {
    
    private let sponsorsDataModel = SponsorsData.allSponsors
    
    weak var delegate: SponsorsViewDelegate?
    
    // MARK: - Components
    private let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.sectionInset = UIEdgeInsets(top: 8, left: 12, bottom: 2, right: 12)
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.register(SponsorsCollectionViewCell.self, forCellWithReuseIdentifier: SponsorsCollectionViewCell.cellID)
        collectionView.backgroundColor = .systemBackground
        return collectionView
    }()
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
}

// MARK: - SetupUI
private extension SponsorsController {
    private func setupUI() {
        title = "Sponsors"
        view.backgroundColor = .systemGray6
        
        setupCollectionView()
    }
    
    private func setupCollectionView() {
        self.view.addSubview(collectionView)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
        
        collectionView.delegate = self
        collectionView.dataSource = self
    }
}


// MARK: - CollectionViewDelegate & CollectionViewDataSource
extension SponsorsController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return sponsorsDataModel.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SponsorsCollectionViewCell.cellID, for: indexPath) as? SponsorsCollectionViewCell else {
            return UICollectionViewCell()
        }
        
        let modelData = sponsorsDataModel[indexPath.row]
        cell.configureCell(withModel: modelData)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 120, height: 80)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let modelData = sponsorsDataModel[indexPath.row]
        guard let url = modelData.url else { return }
        presentSafariController(withURL: url)
    }
}

