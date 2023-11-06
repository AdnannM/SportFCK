//
//  Date.swift
//  FC Kufstein
//
//  Created by Adnann Muratovic on 06.11.23.
//

import Foundation

extension Date {
    func formattedDateString() -> String {
        let outputDateFormatter = DateFormatter()
        outputDateFormatter.dateFormat = "E, MMM d, yyyy"
        return outputDateFormatter.string(from: self)
    }
}
