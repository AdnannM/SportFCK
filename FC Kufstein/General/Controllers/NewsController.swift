//
//  NewsController.swift
//  FC Kufstein
//
//  Created by Adnann Muratovic on 12.10.23.
//

import UIKit

class NewsController: UIViewController {
    
    // MARK: - Components
    private let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.sectionInset = UIEdgeInsets(top: 8, left: 2, bottom: 2, right: 2)
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.register(NewsCollectionViewCell.self, forCellWithReuseIdentifier: NewsCollectionViewCell.cellID)
        collectionView.register(ShimmerCollectionViewCell.self, forCellWithReuseIdentifier: ShimmerCollectionViewCell.cellID)
        collectionView.backgroundColor = .systemBackground
        return collectionView
    }()
    
    var posts = [Post]()
    private let refreshControl = UIRefreshControl()
    var isFetchingData = true
    private var shouldStartRefreshControl = true
    
    // MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        fetchAndDisplayNews()
        setupRefreshControl()
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        if shouldStartRefreshControl {
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) { // Delay the call
                self.refreshControl.beginRefreshing()
                self.refreshData()
            }
            shouldStartRefreshControl = false
        }
    }
    
    // MARK: - Helpers
    func startShimmer() {
        isFetchingData = true
        collectionView.reloadData()
    }

    func stopShimmer() {
        isFetchingData = false
        collectionView.reloadData()
    }
}

// MARK: - Setup
private extension NewsController {
    private func setupUI() {
        title = "FC Kufstein News"
        view.backgroundColor = .systemGray6
        setupTableView()
    }
    
    private func setupTableView() {
        view.addSubview(collectionView)
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

// MARK: - TableViewDelegate & TableViewDataSource
extension NewsController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return isFetchingData ? 9 : posts.count
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
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let deviceName = UIDevice.current.name
        let screenSizeCategory = getScreenSizeCategory(for: deviceName)
        
        var cellSize: CGSize

        switch screenSizeCategory {
        case .small:
            cellSize = CGSize(width: 330, height: 250) // make test
        case .medium:
            cellSize = CGSize(width: 350, height: 250)
        case .large:
            cellSize = CGSize(width: 390, height: 250)
        }

        return cellSize
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let modelURL = posts[indexPath.row]
        presentSafariController(withURL: URL(string: modelURL.link)!)
    }
}


//MARK: - Networking
extension NewsController {
    private func fetchNews() async throws -> [Post] {
        return try await NewsFetcher.shared.fetchNews()
    }

    private func fetchAndDisplayNews() {
        startShimmer()
        Task {
            do {
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

    // MARK: - Refresh Control Setup
    private func setupRefreshControl() {
        collectionView.refreshControl = refreshControl
        refreshControl.addTarget(self, action: #selector(refreshData), for: .valueChanged)
        refreshData()
    }
}

// MARK: - Action
extension NewsController {
    @objc private func refreshData() {
        // Start the shimmer effect immediately
        startShimmer()
        
        Task {
            do {
                // Fetch news posts
                let fetchedPosts = try await fetchNews()
                posts = fetchedPosts
                DispatchQueue.main.async {
                    self.collectionView.reloadData()
                }
            } catch {
                print("Error fetching news: \(error)")
            }
            
            // Stop the refresh control
            refreshControl.endRefreshing()
            // Stop the shimmer effect after data is loaded
            stopShimmer()
        }
    }
}
