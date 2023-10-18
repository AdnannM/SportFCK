//
//  SponsorsView.swift
//  FC Kufstein
//
//  Created by Adnann Muratovic on 13.10.23.
//

import UIKit

protocol SponsorsViewDelegate: AnyObject {
    func openURL(_ url: URL)
}

class SponsorsView: UIView {
    
    // MARK: - Properties
    weak var delegate: SponsorsViewDelegate?
    
    // MARK: - Placeholder Data
    private var sponsorsDataModel = [
        SponsorsModelData(image: UIImage(named: "alpquell-logo")!, url: URL(string: "https://www.alpquell.com/")),
        SponsorsModelData(image: UIImage(named: "FC Kufstein")!, url: URL(string: "https://www.kellys.at/")),
        SponsorsModelData(image: UIImage(named: "stadt-kufstein")!, url: URL(string: "https://www.kufstein.gv.at/")),
        SponsorsModelData(image: UIImage(named: "Interspar")!, url: URL(string: "https://www.interspar.at/")),
        SponsorsModelData(image: UIImage(named: "kufnet")!, url: URL(string: "https://www.kufnet.at/")),
        SponsorsModelData(image: UIImage(named: "kufstein-galerie")!, url: URL(string: "https://www.kufstein-galerien.at/home/?no_cache=1")),
        SponsorsModelData(image: UIImage(named: "LOsteria1")!, url: URL(string: "https://losteria.net/at/")),
        SponsorsModelData(image: UIImage(named: "moccador")!, url: URL(string: "https://www.moccador.at/de/partner-199/praesentation/aktuell")),
        SponsorsModelData(image: UIImage(named: "rztrsdfdsdElement-1")!, url: URL(string: "https://www.ricado-networks.com/")),
    ]
    
    // MARK: - Components
    private let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.sectionInset = UIEdgeInsets(top: 2, left: 2, bottom: 2, right: 2)
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.register(SponsorsCollectionViewCell.self, forCellWithReuseIdentifier: SponsorsCollectionViewCell.cellID)
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
private extension SponsorsView {
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

// MARK: - CollectionViewDelegate & CollectionViewDataSource
extension SponsorsView: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 9
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
        delegate?.openURL(url)
    }
}
