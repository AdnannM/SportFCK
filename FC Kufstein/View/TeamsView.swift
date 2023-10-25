//
//  TeamsView.swift
//  FC Kufstein
//
//  Created by Adnann Muratovic on 13.10.23.
//

import UIKit

class TeamsView: UIView {
    
    // MARK: - Properties
    private var teamsModelData = TeamsData.nextGenerationModel
    
    weak var delegate: SponsorsViewDelegate?
    
    // MARK: - Components
    private let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.sectionInset = UIEdgeInsets(top: 2, left: 2, bottom: 2, right: 2)
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.register(TeamsCollectionViewCell.self, forCellWithReuseIdentifier: TeamsCollectionViewCell.cellID)
        collectionView.backgroundColor = .systemBackground
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
    
    override var intrinsicContentSize: CGSize {
        return CGSize(width: 150, height: 150)
    }
}

// MARK: - SetupUI
private extension TeamsView {
    private func setupUI() {
        backgroundColor = .systemBackground
        layer.cornerRadius = 8
        
        setupCollectionView()
    }
    
    private func setupCollectionView() {
        self.addSubview(collectionView)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: topAnchor),
            collectionView.leadingAnchor.constraint(equalTo: leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
        
        collectionView.delegate = self
        collectionView.dataSource = self
    }
}


extension TeamsView: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return teamsModelData.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TeamsCollectionViewCell.cellID, for: indexPath) as? TeamsCollectionViewCell else {
            return UICollectionViewCell()
        }
        
        let model = teamsModelData[indexPath.item]
        cell.configure(withModel: model)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let deviceName = UIDevice.current.name
        let screenSizeCategory = getScreenSizeCategory(for: deviceName)
        
        var cellSize: CGSize

        switch screenSizeCategory {
        case .small:
            cellSize = CGSize(width: 150, height: 100)
        case .medium:
            cellSize = CGSize(width: 160, height: 100)
        case .large:
            cellSize = CGSize(width: 180, height: 100)
        }

        return cellSize
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let model = teamsModelData[indexPath.item]
        delegate?.openTeamsURL(URL(string: model.url)!)
    }
}
