//
//  UIView.swift
//  FC Kufstein
//
//  Created by Adnann Muratovic on 09.11.23.
//

import UIKit

extension UIView {
    static func createView(withColor color: UIColor) -> UIView {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = color
        return view
    }
}
