//
//  LastGameInfo.swift
//  FC Kufstein
//
//  Created by Adnann Muratovic on 03.11.23.
//

import UIKit

struct LastGameInfo: Decodable {
    let letztes: LastMatch
    
    struct LastMatch: Decodable {
        let datum: Int
        let heimName: String
        let heimTore: String
        let gastName: String
        let gastTore: String
        let bewerbBezeichnung: String
        let spielort: String
        let heimLogo: String
        let gastLogo: String
        let art: String
        let toreHeim: [Tore]
        let toreGast: [Tore]
        let ticker: String
        let ergebnis: String
        let type: String?
    }

    struct Tore: Decodable {
        let minute: String
        let spielerName: String
    }
}
