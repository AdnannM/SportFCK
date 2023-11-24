//
//  HomeController+Extension.swift
//  FC Kufstein
//
//  Created by Adnann Muratovic on 22.11.23.
//

import UIKit
import SwiftUI

// MARK: - Action
extension HomeController {
    @objc func didTapSettings() {
        let hostController = UIHostingController(rootView: SettingsSwiftUIView())
        present(hostController, animated: true)
    }
    
    @objc func didTapShopButton() {
        self.navigationController?.pushViewController(ShopController(), animated: true)
    }
}

// MARK: - ContainerViewDelegate
extension HomeController: HomeContainerViewDelegate {
    func didTapAllMatch(_ view: HomeContainerView) {
        self.navigationController?.pushViewController(AllMatchController(), animated: true)
    }
}

// MARK: - NewsContainerViewDelegate
extension HomeController: NewsContainerViewDelegate {
    func didTapAllNews(_ view: NewsContainerView) {
        self.navigationController?.pushViewController(NewsController(), animated: true)
    }
}

// MARK: - VideoContainerDelegate
extension HomeController: VideoContainerViewDelegate {
    func didTapVideoButton(_ view: VideoContainerView) {
        self.navigationController?.pushViewController(VideoController(), animated: true)
    }
}

// MARK: - TeamsContainerViewDelegate
extension HomeController: TeamsContainerViewDelegate {
    func didTapTeams(_ view: TeamsContainerView) {
        self.navigationController?.pushViewController(TeamsController(), animated: true)
    }
}

// MARK: - SponsorsContainerViewDelegate
extension HomeController: SponsorsContainerViewDelegate {
    func didTapSponsors(_ view: SponsorsContainerView) {
        self.navigationController?.pushViewController(SponsorsController(), animated: true)
    }
}

// MARK: - VideoCollectionViewCellDelegate
extension HomeController: VideoCollectionViewCellDelegate {
    func videoCellImageTapped() {
        /// TODO: - Parse data for Youtube Api latter
        let videoURL = "https://www.youtube.com/embed/0xZU3Sn0KXs"
        
        let videoPlayerVC = VideoPlayerViewController()
        videoPlayerVC.loadYouTubeVideo(videoURL: videoURL)
    
        self.navigationController?.pushViewController(videoPlayerVC, animated: true)
    }
}

// MARK: - SponsorsViewDelegate
extension HomeController: SponsorsViewDelegate {
    func openTeamsURL(_ url: URL) {
        presentSafariController(withURL: url)
    }
    
    func openURL(_ url: URL) {
        presentSafariController(withURL: url)
    }
}

// MARK: - NewsViewDelegate
extension HomeController: NewsViewDelegate {
   
    func didTapNewsCell(_ url: String) {
        presentSafariController(withURL: URL(string: url)!)
    }
    
    func didTapShareButton(in cell: NewsCollectionViewCell, at indexPath: IndexPath) {
        let postIndex = indexPath.row
        let postsCount = newsContainerView.newsView.posts.count

        guard postIndex >= 0, postIndex < postsCount else {
            print("Index out of bounds")
            return
        }

        let post = newsContainerView.newsView.posts[postIndex]

        // Ensure the properties of 'post' are valid
        guard let url = URL(string: post.link) else {
            print("URL couldn't be created")
            return
        }
        
        let shareText = "Check out this article: \(post.title.rendered)\n\(post.link)"
        let activityViewController = UIActivityViewController(activityItems: [shareText, url], applicationActivities: nil)

        activityViewController.excludedActivityTypes = [
            .addToReadingList,
            .assignToContact,
            // Add more excluded activities as per your requirement
        ]

        present(activityViewController, animated: true)
    }
}
