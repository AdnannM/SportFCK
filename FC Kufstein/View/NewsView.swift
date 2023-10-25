//
//  NewsView.swift
//  FC Kufstein
//
//  Created by Adnann Muratovic on 12.10.23.
//

import UIKit

class NewsView: UIView {
    
    // MARK: - Components
    private let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.sectionInset = UIEdgeInsets(top: 2, left: 2, bottom: 2, right: 2)
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.register(NewsCollectionViewCell.self, forCellWithReuseIdentifier: NewsCollectionViewCell.cellID)
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
private extension NewsView {
    private func setupUI() {
        backgroundColor = .systemBackground
        layer.cornerRadius = 20
        
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

extension NewsView: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 4
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: NewsCollectionViewCell.cellID, for: indexPath) as? NewsCollectionViewCell else {
            return UICollectionViewCell()
        }
        
        return cell
    }
    
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//        return CGSize(width: 330, height: 280)
//    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let deviceName = UIDevice.current.name
        let screenSizeCategory = getScreenSizeCategory(for: deviceName)
        
        var cellSize: CGSize

        switch screenSizeCategory {
        case .small:
            cellSize = CGSize(width: 310, height: 280)
        case .medium:
            cellSize = CGSize(width: 330, height: 280)
        case .large:
            cellSize = CGSize(width: 370, height: 280)
        }

        return cellSize
    }
}



class NewsCollectionViewCell: UICollectionViewCell {
    
    // MARK: - Properties
    static let cellID = "NewsCollectionViewCell"
    
    private let testView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .red
        view.layer.cornerRadius = 20
        return view
    }()
    
    private let circleView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .systemBackground
        return view
    }()
    
    private let circleView1: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .label
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .systemBackground
        layer.cornerRadius = 20
        
        contentView.addSubview(testView)
        testView.addSubview(circleView)
        circleView.addSubview(circleView1)
        
        NSLayoutConstraint.activate([
            testView.topAnchor.constraint(equalTo: contentView.topAnchor),
            testView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            testView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            testView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            
            circleView.bottomAnchor.constraint(equalTo: testView.bottomAnchor, constant: 10),
            circleView.trailingAnchor.constraint(equalTo: testView.trailingAnchor, constant: 8),
            circleView.widthAnchor.constraint(equalToConstant: 100), // Set the width and height to create a circle
            circleView.heightAnchor.constraint(equalTo: circleView.widthAnchor),
            
            circleView1.topAnchor.constraint(equalTo: circleView.topAnchor, constant: 10),
            circleView1.trailingAnchor.constraint(equalTo: circleView.trailingAnchor, constant: -10),
            circleView1.leadingAnchor.constraint(equalTo: circleView.leadingAnchor, constant: 10),
            circleView1.bottomAnchor.constraint(equalTo: circleView.bottomAnchor, constant: -10),
            
            circleView1.widthAnchor.constraint(equalToConstant: 80), // Set the width and height to create a circle
            circleView1.heightAnchor.constraint(equalTo: circleView1.widthAnchor),
        ])
        
        circleView.layer.cornerRadius = 50 // Set half of the width to make it circular
        circleView.clipsToBounds = true
        circleView1.clipsToBounds = true
        circleView1.layer.cornerRadius = 40
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
