//
//  SponsorsModelData.swift
//  FC Kufstein
//
//  Created by Adnann Muratovic on 18.10.23.
//

import UIKit

struct SponsorsModelData {
    let image: UIImage
    let url: URL?
}

struct SponsorsData {
    static let allSponsors: [SponsorsModelData] = [
        SponsorsModelData(image: UIImage(named: "alpquell-logo")!, url: URL(string: "https://www.alpquell.com/")),
        SponsorsModelData(image: UIImage(named: "FC Kufstein")!, url: URL(string: "https://www.kellys.at/")),
        SponsorsModelData(image: UIImage(named: "stadt-kufstein")!, url: URL(string: "https://www.kufstein.gv.at/")),
        SponsorsModelData(image: UIImage(named: "Interspar")!, url: URL(string: "https://www.interspar.at/")),
        SponsorsModelData(image: UIImage(named: "kufnet")!, url: URL(string: "https://www.kufnet.at/")),
        SponsorsModelData(image: UIImage(named: "kufstein-galerie")!, url: URL(string: "https://www.kufstein-galerien.at/home/?no_cache=1")),
        SponsorsModelData(image: UIImage(named: "LOsteria1")!, url: URL(string: "https://losteria.net/at/")),
        SponsorsModelData(image: UIImage(named: "moccador")!, url: URL(string: "https://www.moccador.at/de/partner-199/praesentation/aktuell")),
        SponsorsModelData(image: UIImage(named: "rztrsdfdsdElement-1")!, url: URL(string: "https://www.ricado-networks.com/")),
    ]
}
