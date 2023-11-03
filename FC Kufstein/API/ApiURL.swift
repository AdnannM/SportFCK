//
//  ApiURL.swift
//  FC Kufstein
//
//  Created by Adnann Muratovic on 03.11.23.
//

import Foundation

enum ApiURL {
    struct Constants {
        static let baseURL = "https://fc-kufstein.at/wp-json/wp/v2/posts"
        static let mainTeamMatchURL = URL(string: "https://vereine.oefb.at/proxy/VereinMasterProject/834733022602002384_widget_data_9bb733053d?proxyUrl=http%3A%2F%2Fportale-datenservice%3A8080%2Fdatenservice%2Frest%2Fvereinswidget%2Fdata%2F9bb733053d")!
        static let mainTeamTableURL = URL(string: "https://vereine.oefb.at/proxy/VereinMasterProject/834733022602002384_widget_data_19c3e4bace?proxyUrl=http%3A%2F%2Fportale-datenservice%3A8080%2Fdatenservice%2Frest%2Fvereinswidget%2Fdata%2F19c3e4bace")!
        static let juniorsTableURL = URL(string: "https://vereine.oefb.at/proxy/VereinMasterProject/834733022602002384_widget_data_9c2230c862?proxyUrl=http%3A%2F%2Fportale-datenservice%3A8080%2Fdatenservice%2Frest%2Fvereinswidget%2Fdata%2F9c2230c862")!
        static let lastGameURL = URL(string: "https://vereine.oefb.at/proxy/VereinMasterProject/834733022602002384_widget_data_17b1829867?proxyUrl=http%3A%2F%2Fportale-datenservice%3A8080%2Fdatenservice%2Frest%2Fvereinswidget%2Fdata%2F17b1829867")!
    }
}
