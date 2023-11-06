//
//  UIImageView.swift
//  FC Kufstein
//
//  Created by Adnann Muratovic on 06.11.23.
//

import UIKit

extension UIImageView {
    static func createImageView(withImage image: UIImage) -> UIImageView {
        let imageView = UIImageView()
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFit
        imageView.image = image
        return imageView
    }
}
