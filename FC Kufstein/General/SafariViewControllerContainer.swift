//
//  SafariViewControllerContainer.swift
//  FC Kufstein
//
//  Created by Adnann Muratovic on 18.10.23.
//

import UIKit
import SafariServices

final class SafariViewControllerContainer: UIViewController {
    
    // MARK: - Properties
    private var timer: Timer?
    
    // MARK: - Components
    private var safariViewController: SFSafariViewController!
    private var activityIndicator: UIActivityIndicatorView!

    // MARK: - Lifecycle
    init(url: URL) {
        super.init(nibName: nil, bundle: nil)
        safariViewController = SFSafariViewController(url: url)
        safariViewController.delegate = self
        activityIndicator = UIActivityIndicatorView(style: .large)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
}

// MARK: - Setup
extension SafariViewControllerContainer {
    private func setup() {
        addChild(safariViewController)
        view.addSubview(safariViewController.view)
        safariViewController.view.frame = view.bounds
        safariViewController.didMove(toParent: self)
        
        activityIndicator.center = view.center
        activityIndicator.hidesWhenStopped = true
        view.addSubview(activityIndicator)
        
        // Start the activity indicator when the view appears
        activityIndicator.startAnimating()
        
        // Create a timer to periodically check if the Safari view controller is dismissed
        let timer = Timer(timeInterval: 0.5, repeats: true) { [weak self] _ in
            if self?.safariViewController.isBeingDismissed == true {
                // Stop the activity indicator when the Safari view controller is dismissed
                self?.activityIndicator.stopAnimating()
                self?.safariViewController = nil
                self?.invalidateTimer()
            }
        }
        RunLoop.current.add(timer, forMode: .common)
    }
    
    private func invalidateTimer() {
        // Stop and invalidate the timer
        // This prevents the timer from running after it's no longer needed
        timer?.invalidate()
        timer = nil
    }
}

// MARK: - SFSafariViewControllerDelegate
extension SafariViewControllerContainer: SFSafariViewControllerDelegate {
    func safariViewController(_ controller: SFSafariViewController, didCompleteInitialLoad didLoadSuccessfully: Bool) {
        // Check if the initial load of the website was successful
        if didLoadSuccessfully {
            // If the website loads successfully, we can stop the activity indicator
            activityIndicator.stopAnimating()
            invalidateTimer()
        }
    }
}
