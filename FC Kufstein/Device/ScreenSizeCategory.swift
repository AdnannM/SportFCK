//
//  ScreenSizeCategory.swift
//  FC Kufstein
//
//  Created by Adnann Muratovic on 25.10.23.
//

import UIKit

/// TODO: - Implement one more screen size 6.5

enum ScreenSizeCategory {
    case small // iPhone SE, iPhone 13 mini, etc.
    case medium // iPhone XS, iPhone 12, iPhone 13, etc.
    case large // iPhone XS Max, iPhone 12 Pro Max, etc.
}

func getScreenSizeCategory(for deviceName: String) -> ScreenSizeCategory {
    switch deviceName {
    case "iPhone SE (2020)", "iPhone SE (3rd generation)", "iPhone 12 mini", "iPhone 13 mini":
        return .small
    case "iPhone XS", "iPhone 12", "iPhone 13", "iPhone 14", "iPhone 15", "iPhone 12 Pro", "iPhone 13 Pro", "iPhone 14 Pro", "iPhone 15 Pro":
        return .medium
    case "iPhone XS Max", "iPhone 12 Pro Max", "iPhone 13 Pro Max", "iPhone 14 Plus", "iPhone 14 Pro Max", "iPhone 15 Plus", "iPhone 15 Pro Max":
        return .large
    default:
        return .large // Default to large size
    }
}

// MARK: - Helpers
func createView(color: UIColor) -> UIView {
    let view = UIView()
    view.translatesAutoresizingMaskIntoConstraints = false
    view.backgroundColor = color
    return view
}
