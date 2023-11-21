//
//  PullToRefresh.swift
//  FC Kufstein
//
//  Created by Adnann Muratovic on 21.11.23.
//

import UIKit
import ObjectiveC

private var pullToRefreshKey: UInt8 = 0

extension UITableView {
    private var pullToRefreshAction: (() -> Void)? {
        get {
            return objc_getAssociatedObject(self, &pullToRefreshKey) as? () -> Void
        }
        set {
            objc_setAssociatedObject(self, &pullToRefreshKey, newValue, .OBJC_ASSOCIATION_RETAIN)
        }
    }
    
    func addPullToRefresh(action: @escaping () -> Void) {
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(refreshAction(sender:)), for: .valueChanged)
        self.refreshControl = refreshControl

        // Store the action closure
        self.pullToRefreshAction = action
    }

    @objc private func refreshAction(sender: UIRefreshControl) {
        // Perform the action defined in the closure
        pullToRefreshAction?()
    }
}
