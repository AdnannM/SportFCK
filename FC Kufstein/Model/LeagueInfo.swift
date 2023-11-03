//
//  LeagueInfo.swift
//  FC Kufstein
//
//  Created by Adnann Muratovic on 03.11.23.
//

import UIKit

struct League: Codable {
    let bezeichnung: String
    let tabellen: Tabellen
}

struct Tabellen: Codable {
    let HEIM: Table
}

struct Table: Codable {
    let eintraege: [Entry]
}

struct Entry: Codable {
    let rang: Int
    let mannschaftBezeichnung: String
    let mannschaftIcon: String
    let spiele: Int
    let toreErzielt: Int
    let punkte: Int
    let tordifferenz: Int
}
