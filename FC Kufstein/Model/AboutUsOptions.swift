//
//  SettingsOptions.swift
//  FC Kufstein
//
//  Created by Adnann Muratovic on 16.11.23.
//

import UIKit

struct AboutUsOptions {
    let title: String
    let icon: UIImage?
    let iconBackground: UIColor
    let handler: (() ->Void)
}

struct AboutUsSection {
    let tittle: String
    let options: [AboutUsOptions]
}
