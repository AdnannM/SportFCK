//
//  LastMatchInfo.swift
//  FC Kufstein
//
//  Created by Adnann Muratovic on 03.11.23.
//

import UIKit

struct MetchInfo: Decodable, Encodable {
    let bezeichnung: String
    let detailUrl: String
    let plan: [String: [KMData]]

    struct KMData: Decodable, Encodable {
        let datum: Int
        let live: Bool
        let ergebnis: String?
        let heimName: String
        let heimLogoId: String?
        let heimTore: String
        let gastName: String
        let gastLogoId: String?
        let gastTore: String
        let bewerbBezeichnung: String
        let spielort: String
        let heimLogo: String?
        let gastLogo: String?
    }
}
