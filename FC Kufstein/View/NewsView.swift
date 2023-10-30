//
//  NewsView.swift
//  FC Kufstein
//
//  Created by Adnann Muratovic on 12.10.23.
//

import UIKit

protocol NewsViewDelegate: AnyObject {
    func didTapNewsCell(_ url: String)
    func didTapShareButton(in cell: NewsCollectionViewCell)
}


class NewsView: UIView {
    
    // MARK: - Components
    private let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.sectionInset = UIEdgeInsets(top: 2, left: 2, bottom: 2, right: 2)
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.register(NewsCollectionViewCell.self, forCellWithReuseIdentifier: NewsCollectionViewCell.cellID)
        collectionView.register(ShimmerCollectionViewCell.self, forCellWithReuseIdentifier: ShimmerCollectionViewCell.cellID)
        collectionView.backgroundColor = .systemBackground
        return collectionView
    }()
    
    weak var delegate: NewsViewDelegate?
    var posts = [Post]()
    
    var isFetchingData = true
    
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
    
    override func layoutSubviews() {
        super.layoutSubviews()
        Task {
            do {
                startShimmer()
                let fetchedPosts = try await fetchNews()
                posts = fetchedPosts
                DispatchQueue.main.async {
                    self.collectionView.reloadData()
                }
                stopShimmer()
            } catch {
                print("Error fetching news: \(error)")
            }
        }
    }
    
    func startShimmer() {
        isFetchingData = true
        collectionView.reloadData()
    }

    func stopShimmer() {
        isFetchingData = false
        collectionView.reloadData()
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
        return isFetchingData ? 2 : posts.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if isFetchingData {
            return collectionView.dequeueReusableCell(withReuseIdentifier: ShimmerCollectionViewCell.cellID, for: indexPath)
        } else {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: NewsCollectionViewCell.cellID, for: indexPath) as? NewsCollectionViewCell else {
                return UICollectionViewCell()
            }
    
            let post = posts[indexPath.row]
            cell.configure(withData: post)
            cell.delegate = self.delegate
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let deviceName = UIDevice.current.name
        let screenSizeCategory = getScreenSizeCategory(for: deviceName)
        
        var cellSize: CGSize

        switch screenSizeCategory {
        case .small:
            cellSize = CGSize(width: 310, height: 250)
        case .medium:
            cellSize = CGSize(width: 330, height: 250)
        case .large:
            cellSize = CGSize(width: 370, height: 250)
        }

        return cellSize
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let modelURL = posts[indexPath.row]
        delegate?.didTapNewsCell(modelURL.link)
    }
}


//MARK: - Networking
extension NewsView {
    func fetchNews() async throws -> [Post] {
        let posts = try await ApiManager.shared.getPosts()
        let formattedPosts = formatPosts(posts)
        return formattedPosts
    }

    func formatPosts(_ posts: [Post]) -> [Post] {
        var formattedPosts = [Post]()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
        let outputFormatter = DateFormatter()
        outputFormatter.dateFormat = "MMM dd, yyyy"

        for post in posts {
            if let date = dateFormatter.date(from: post.date) {
                let formattedDate = outputFormatter.string(from: date)
                let formattedPost = Post(id: post.id, date: formattedDate, link: post.link, title: post.title, jetpackFeaturedMediaURL: post.jetpackFeaturedMediaURL)
                formattedPosts.append(formattedPost)
            } else {
                print("Error formatting date for post ID \(post.id)")
            }
        }
        return formattedPosts
    }
}

