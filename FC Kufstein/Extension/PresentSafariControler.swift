//
//  PresentSafariControler.swift
//  FC Kufstein
//
//  Created by Adnann Muratovic on 18.10.23.
//

import UIKit

extension UIViewController {
     func presentSafariController(withURL url: URL) {
        let safariContainer = SafariViewControllerContainer(url: url)
        safariContainer.modalPresentationStyle = .fullScreen
        present(safariContainer, animated: true)
    }
}
