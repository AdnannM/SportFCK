//
//  VideoPlayerViewController.swift
//  FC Kufstein
//
//  Created by Adnann Muratovic on 17.10.23.
//

import UIKit
import WebKit

final class VideoPlayerViewController: UIViewController {
    
    // MARK: - Properties
    let webView = WKWebView()
    let activityIndicator = UIActivityIndicatorView()

    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }

    // MARK: - Helpers
    func loadYouTubeVideo(videoURL: String) {
        if let url = URL(string: videoURL) {
            let request = URLRequest(url: url)
            webView.load(request)
        }
    }
}

// MARK: - SetupUI
private extension VideoPlayerViewController {
    private func setupUI() {
        setupWebView()
        setupActivityIndicator()
    }
    
    private func setupActivityIndicator() {
        // Add an activity indicator
        activityIndicator.style = .large
        activityIndicator.center = view.center
        activityIndicator.hidesWhenStopped = true
        view.addSubview(activityIndicator)
        activityIndicator.startAnimating()
    }
    
    private func setupWebView() {
        title = "FC Kufstein TV" // Set your desired title
        view.backgroundColor = .systemGray6
        
        // Add a WKWebView
        view.addSubview(webView)
        webView.navigationDelegate = self
        webView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            webView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            webView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            webView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            webView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
}

// MARK: - WKNavigationDelegate
extension VideoPlayerViewController: WKNavigationDelegate {
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        activityIndicator.stopAnimating()
    }
}
