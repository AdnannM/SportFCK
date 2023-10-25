//
//  VideoView.swift
//  FC Kufstein
//
//  Created by Adnann Muratovic on 12.10.23.
//

import UIKit

class VideoView: UIView {
    
    // MARK: - Properties
    weak var delegate: VideoCollectionViewCellDelegate?

    
    // MARK: - Components
    private let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.sectionInset = UIEdgeInsets(top: 2, left: 2, bottom: 2, right: 2)
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.register(VideoCollectionViewCell.self, forCellWithReuseIdentifier: VideoCollectionViewCell.cellID)
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
private extension VideoView {
    private func setupUI() {
        backgroundColor = .systemBackground
        layer.cornerRadius = 8
        setupCollectionView()
    }
    
    private func setupCollectionView() {
        addSubview(collectionView)
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

extension VideoView: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: VideoCollectionViewCell.cellID, for: indexPath) as? VideoCollectionViewCell else {
            return UICollectionViewCell()
        }
        
        cell.videoURL = URL(string: "https://www.youtube.com/watch?v=0xZU3Sn0KXs")
        cell.delegate = self
        cell.layer.cornerRadius = 8
        
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let deviceName = UIDevice.current.name
        let screenSizeCategory = getScreenSizeCategory(for: deviceName)
        
        var cellSize: CGSize

        switch screenSizeCategory {
        case .small:
            cellSize = CGSize(width: 310, height: 180)
        case .medium:
            cellSize = CGSize(width: 330, height: 180)
        case .large:
            cellSize = CGSize(width: 370, height: 180)
        }

        return cellSize
    }
}

extension VideoView: VideoCollectionViewCellDelegate {
    func videoCellImageTapped() {
        delegate?.videoCellImageTapped()
    }
}
