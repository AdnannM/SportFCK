//
//  TeamsModelData.swift
//  FC Kufstein
//
//  Created by Adnann Muratovic on 19.10.23.
//

import UIKit

enum AgeGroup: String, CaseIterable {
    case kufstein = ""
    case juniors = "-juniors"
    case u16 = "u16a"
    case u15a = "u16b-2"
    case u15b = "u15b"
    case u13 = "u13"
    case u12 = "u12"
    case u11 = "u11"
    case u10 = "u10"
    case u9 = "u9"
    case u8 = "u8"
    case u7 = "u7"
    case kindergarten = "kindergarten"
    
    var url: String {
        return "https://fc-kufstein.at/fc-kufstein-\(self.rawValue)/"
    }
    
    var image: UIImage? {
        switch self {
        case .u16:
            return UIImage(named: "u16")
        case .u15a:
            return UIImage(named: "u15a")
        case .u15b:
            return UIImage(named: "u15b")
        case .u13:
            return UIImage(named: "u13")
        case .u12:
            return UIImage(named: "u12")
        case .u11:
            return UIImage(named: "u11")
        case .u10:
            return UIImage(named: "u10")
        case .u9:
            return UIImage(named: "u9")
        case .u8:
            return UIImage(named: "u8")
        case .u7:
            return UIImage(named: "u7")
        case .kindergarten:
            return UIImage(named: "u6")
        case .kufstein:
            return UIImage(named: "kufstein")
        case .juniors:
            return UIImage(named: "juniors")
        }
    }
}

struct TeamsData {
    static let nextGenerationModel = AgeGroup.allCases.map { TeamsModelData(image: $0.image, url: $0.url) }
}

struct TeamsModelData {
    let image: UIImage?
    let url: String
}
