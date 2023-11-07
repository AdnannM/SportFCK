//
//  Labels.swift
//  FC Kufstein
//
//  Created by Adnann Muratovic on 11.10.23.
//

import UIKit

extension UILabel {
    static func createCustomLabel(text: String, textColor: UIColor, fontSize: CGFloat, fontWeight: UIFont.Weight) -> UILabel {
        let label = UILabel()
        label.textColor = textColor
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: fontSize, weight: fontWeight)
        label.text = text
        return label
    }
}


