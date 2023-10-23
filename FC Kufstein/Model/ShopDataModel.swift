//
//  ShopDataModel.swift
//  FC Kufstein
//
//  Created by Adnann Muratovic on 20.10.23.
//

import UIKit

struct ShopDataModel {
    var category: String?
    var image: UIImage
    var title: String
    var price: String
    var url: URL
    
    struct ShopModel {
        var model = [
            ShopDataModel(
                category: "jacken",
                image: UIImage(named: "shopImage1")!,
                title: "RAIN JACKET",
                price: "68,90 € – 73,90 €",
                url: URL(string: "https://fc-kufstein.at/produkt/youth-basics-training-jacket-2/")!
            ), // 1  Jacken
            
            ShopDataModel(
                category: "jacken",
                image: UIImage(named: "shopImage2")!,
                title: "TRAINING JACKET",
                price: "38,90 € – 43,90 €",
                url: URL(string: "https://fc-kufstein.at/produkt/youth-basics-training-jacket/")!
            ), // 2  Jacken
            
            
            ShopDataModel(
                category: "oberteile",
                image: UIImage(named: "shopImage3")!,
                title: "ZIP TRAINING TOP",
                price: "38,90 € – 43,90 €",
                url: URL(string: "https://fc-kufstein.at/produkt/youth-basics-1%e2%81%844-zip-training-top/")!
            ), // 3  Oberteile
            
            ShopDataModel(
                category: "oberteile",
                image: UIImage(named: "shopImage4")!,
                title: "LONG SLEEVE SWEAT",
                price: "43,90 € – 48,90 €",
                url: URL(string: "https://fc-kufstein.at/produkt/chelsea-jersey-2/")!
            ), // 4  Oberteile
            
            ShopDataModel(
                category: "oberteile",
                image: UIImage(named: "shopImage5")!,
                title: "HOODIE WITH EMBROIDERED",
                price: "43,90 € – 48,90 €",
                url: URL(string: "https://fc-kufstein.at/produkt/basics-hoodie-with-embroidered-logo-on-chest/")!
            ), // 5  Oberteile
            
            ShopDataModel(
                category: "oberteile",
                image: UIImage(named: "shopImage6")!,
                title: "CS ONE JERSEY",
                price: "20,90 € – 21,90 €",
                url: URL(string: "https://fc-kufstein.at/produkt/cs-one-jersey/")!
            ), // 6  Oberteile
            
            ShopDataModel(
                category: "oberteile",
                image: UIImage(named: "shopImage7")!,
                title: "COTTON POLO SHIRT",
                price: "33,90 € – 38,90 €",
                url: URL(string: "https://fc-kufstein.at/produkt/basic-cotton-polo-shirt/")!
            ), // 7  Oberteile
            
            ShopDataModel(
                category: "oberteile",
                image: UIImage(named: "shopImage8")!,
                title: "LOGO T-SHIRT",
                price: "17,90 € – 19,90 €",
                url: URL(string: "https://fc-kufstein.at/produkt/logo-t-shirt/")!
            ), // 8  Oberteile
            
            ShopDataModel(
                category: "jacken",
                image: UIImage(named: "shopImage9")!,
                title: "BASIC TEAM JACKET",
                price: "63,90 € – 73,90 €",
                url: URL(string: "https://fc-kufstein.at/produkt/basic-team-jacket/")!
            ), // 9  Jacken
            
            ShopDataModel(
                category: "jacken",
                image: UIImage(named: "shopImage10")!,
                title: "BASIC STADIUM COAT",
                price: "123,90 € – 133,90 €",
                url: URL(string: "https://fc-kufstein.at/produkt/basic-stadium-coat/")!
            ), // 10  Jacken
            

            ShopDataModel(
                category: "unterteile",
                image: UIImage(named: "shopImage11")!,
                title: "BASIC TRAINING PANT",
                price: "27,90 € – 29,90 €",
                url: URL(string: "https://fc-kufstein.at/produkt/basic-training-pant/")!
            ), // 11 Unterteile
            
            ShopDataModel(
                category: "unterteile",
                image: UIImage(named: "shopImage12")!,
                title: "BASIC WOVEN PANT",
                price: "34,90 € – 39,90 €",
                url: URL(string: "https://fc-kufstein.at/produkt/basic-woven-pant-with-pockets/")!
            ), // 12 Unterteile
            
            ShopDataModel(
                category: "unterteile",
                image: UIImage(named: "shopImage13")!,
                title: "BASIC TRAINING SHORT",
                price: "14,90 € – 16,90 €",
                url: URL(string: "https://fc-kufstein.at/produkt/basic-training-short/")!
            ), // 13 Unterteile
            
            ShopDataModel(
                category: "unterteile",
                image: UIImage(named: "shopImage14")!,
                title: "BASIC WOVEN SHORT",
                price: "24,90 € – 25,90 €",
                url: URL(string: "https://fc-kufstein.at/produkt/basic-woven-short-with-pocket/")!
            ), // 14 Unterteile
            
            ShopDataModel(
                category: "oberteile",
                image: UIImage(named: "shopImage15")!,
                title: "BODYWEAR LONGSLEEVE",
                price: "27,90 € – 29,90 €",
                url: URL(string: "https://fc-kufstein.at/produkt/bodywear-longsleeve-performance-top/")!
            ), // 15 Oberteile
            
            ShopDataModel(
                category: "oberteile",
                image: UIImage(named: "shopImage16")!,
                title: "BODYWEAR LONGSLEEVE",
                price: "27,90 € – 29,90 €",
                url: URL(string: "https://fc-kufstein.at/produkt/bodywear-longsleeve-performance-top-2/")!
            ), // 16 Oberteile
            
            ShopDataModel(
                category: "oberteile",
                image: UIImage(named: "shopImage17")!,
                title: "CHELSEA MATCH JERSEY",
                price: "36,90 € – 38,90 €",
                url: URL(string: "https://fc-kufstein.at/produkt/chelsea-match-jersey/")!
            ), // 17 Oberteile
            

            ShopDataModel(
                category: "unterteile",
                image: UIImage(named: "shopImage18")!,
                title: "CS ONE MATCH SHORTS",
                price: "14,90 € – 16,90 €",
                url: URL(string: "https://fc-kufstein.at/produkt/cs-one-match-shorts/")!
            ), // 18 Unterteile
            
            
            ShopDataModel(
                category: "zubehör",
                image: UIImage(named: "shopImage19")!,
                title: "CS ONE SOCCER SOCKS",
                price: "7,90 €",
                url: URL(string: "https://fc-kufstein.at/produkt/cs-one-soccer-socks/")!
            ), // 19 Zubehör
            
            ShopDataModel(
                category: "zubehör",
                image: UIImage(named: "shopImage20")!,
                title: "CAPELLI SPORT LEG SLEEVE",
                price: "9,90 €",
                url: URL(string: "https://fc-kufstein.at/produkt/capelli-sport-leg-sleeve/")!
            ), // 20 Zubehör
            
            
            
            ShopDataModel(
                category: "oberteile",
                image: UIImage(named: "shopImage21")!,
                title: "CHELSEA MATCH JERSEY",
                price: "36,90 € – 38,90 €",
                url: URL(string: "https://fc-kufstein.at/produkt/chelsea-match-jersey-2/")!
            ), // 21 Oberteile
            
            
            ShopDataModel(
                category: "unterteile",
                image: UIImage(named: "shopImage22")!,
                title: "CS ONE MATCH SHORTS",
                price: "14,90 € – 16,90 €",
                url: URL(string: "https://fc-kufstein.at/produkt/cs-one-match-shorts-2/")!
            ), // 22 Unterteile
            
            
            ShopDataModel(
                category: "zubehör",
                image: UIImage(named: "shopImage23")!,
                title: "CS ONE SOCCER SOCKS",
                price: "7,90 €",
                url: URL(string: "https://fc-kufstein.at/produkt/cs-one-soccer-socks-2/")!
            ), // 23 Zubehör
            
            ShopDataModel(
                category: "zubehör",
                image: UIImage(named: "shopImage24")!,
                title: "CAPELLI SPORT LEG SLEEVE",
                price: "9,90 €",
                url: URL(string: "https://fc-kufstein.at/produkt/capelli-sport-leg-sleeve-kopie/")!
            ), // 24 Zubehör
            
            ShopDataModel(
                category: "zubehör",
                image: UIImage(named: "shopImage25")!,
                title: "CS FOOTLESS SOCCER SOCKS",
                price: "5,90 €",
                url: URL(string: "https://fc-kufstein.at/produkt/cs-footless-soccer-socks/")!
            ), // 25 Zubehör
            
            ShopDataModel(
                category: "zubehör",
                image: UIImage(named: "shopImage26")!,
                title: "CS FOOTLESS SOCCER SOCKS",
                price: "5,90 €",
                url: URL(string: "https://fc-kufstein.at/produkt/cs-footless-soccer-socks-2/")!
            ), // 26 Zubehör
            
            ShopDataModel(
                category: "zubehör",
                image: UIImage(named: "shopImage27")!,
                title: "CS CLASSIC CREW SOCKS",
                price: "7,90 €",
                url: URL(string: "https://fc-kufstein.at/produkt/cs-classic-crew-socks-3ppk-w-terry-cushion-fc-kufstein/")!
            ), // 27 Zubehör
            
            ShopDataModel(
                category: "zubehör",
                image: UIImage(named: "shopImage28")!,
                title: "CS TEAM DUFFLE BAG",
                price: "29,90 €",
                url: URL(string: "https://fc-kufstein.at/produkt/cs-team-duffle-bag-small/")!
            ), // 28 Zubehör
            
            ShopDataModel(
                category: "zubehör",
                image: UIImage(named: "shopImage29")!,
                title: "FCK Mütze",
                price: "15,00 €",
                url: URL(string: "https://fc-kufstein.at/produkt/fck-muetze/")!
            ), // 29 Zubehör
            
            ShopDataModel(
                category: "zubehör",
                image: UIImage(named: "shopImage30")!,
                title: "FCK Wimpel klein",
                price: "15,00 €",
                url: URL(string: "https://fc-kufstein.at/produkt/fck-wimpel-klein/")!
            ), // 30 Zubehör
            
            ShopDataModel(
                category: "zubehör",
                image: UIImage(named: "shopImage31")!,
                title: "FCK Wimpel groß",
                price: "20,00 €",
                url: URL(string: "https://fc-kufstein.at/produkt/fck-wimpel-gross/")!
            ), // 31 Zubehör
        ]
    }
}
