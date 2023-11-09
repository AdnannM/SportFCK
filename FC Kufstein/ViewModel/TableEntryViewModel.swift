//
//  TableEntryViewModel.swift
//  FC Kufstein
//
//  Created by Adnann Muratovic on 09.11.23.
//

import UIKit

struct TableEntryViewModel {
    let rankText: String
    let teamNameText: String
    let imageURL: URL?
    let gamePlayersText: String
    let scoreDifferenceText: String
    let pointsText: String

    init(entry: Entry) {
        rankText = "\(entry.rang)."
        teamNameText = entry.mannschaftBezeichnung
        imageURL = URL(string: "https:" + entry.mannschaftIcon)
        gamePlayersText = "\(entry.spiele)"
        scoreDifferenceText = "\(entry.tordifferenz)"
        pointsText = "\(entry.punkte)"
    }
}
