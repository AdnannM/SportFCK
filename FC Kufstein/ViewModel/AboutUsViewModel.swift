//
//  AboutUsViewModel.swift
//  FC Kufstein
//
//  Created by Adnann Muratovic on 17.11.23.
//

import UIKit

enum StaticURL {
    struct Constants {
        static let geschichteURL = "https://fc-kufstein.at/geschichte/"
        static let funktionäreURL = "https://fc-kufstein.at/funktionaere/"
        static let stadionURL = "https://fc-kufstein.at/stadion/"
        static let leitsätzeURL = "https://fc-kufstein.at/leitsaetze/"
        static let fanshopURL = "https://fc-kufstein.at/shop/"
        static let datenschutzURL = "https://fc-kufstein.at/datenschutz/"
        static let impressumURL = "https://fc-kufstein.at/impressum/"
        static let turnieranmledungURL = "https://fc-kufstein.at/tournieranmeldung/"
        static let sommercampAnmeldungURL = "https://fc-kufstein.at/sommercamp-anmeldung/"
        static let facebookURL = "https://www.facebook.com/people/FC-Kufstein/100083368569902/"
        static let instagramURL = "https://www.instagram.com/kufstein_fc/"
        static let xURL = "https://twitter.com/FCKufstein"
        static let youtubeURL = "https://www.youtube.com/user/FCKufstein"
    }
}


protocol AboutUsViewModelDelegate: AnyObject {
    func openURL(withURL url: String)
    func sendEmail()
    func phoneCall()
}

class AboutUsViewModel {
    
    var models = [AboutUsSection]()
    
    weak var delegate: AboutUsViewModelDelegate?
    
    
    func configure() {
        models.append(AboutUsSection(tittle: "Verein", options: [
            AboutUsOptions(title: "Geschichte", icon: UIImage(systemName: "book.circle"), iconBackground: .systemGray4, handler: {
                self.delegate?.openURL(withURL: StaticURL.Constants.geschichteURL)
            }),
            AboutUsOptions(title: "Funktionäre", icon: UIImage(systemName: "person.3"), iconBackground: .systemGray5, handler: {
                self.delegate?.openURL(withURL: StaticURL.Constants.funktionäreURL)
            }),
            AboutUsOptions(title: "Stadion", icon: UIImage(systemName: "mappin.and.ellipse"), iconBackground: .systemGray2, handler: {
                self.delegate?.openURL(withURL: StaticURL.Constants.stadionURL)
            }),
            AboutUsOptions(title: "Leitsätze", icon: UIImage(systemName: "text.justify"), iconBackground: .systemOrange, handler: {
                self.delegate?.openURL(withURL: StaticURL.Constants.leitsätzeURL)
            }),
            
            AboutUsOptions(title: "Fanshop", icon: UIImage(systemName: "giftcard"), iconBackground: .systemGreen, handler: {
                self.delegate?.openURL(withURL: StaticURL.Constants.fanshopURL)
            }),
            
        ]))
        
        models.append(AboutUsSection(tittle: "Rechtliches", options: [
            AboutUsOptions(title: "Datenschutz", icon: UIImage(systemName: "shield"), iconBackground: .systemBlue, handler: {
                self.delegate?.openURL(withURL: StaticURL.Constants.datenschutzURL)
            }),
            AboutUsOptions(title: "Impressum", icon: UIImage(systemName: "doc.text"), iconBackground: .systemRed, handler: {
                self.delegate?.openURL(withURL: StaticURL.Constants.impressumURL)
            }),
        ]))
        
        models.append(AboutUsSection(tittle: "Kontakt", options: [
            AboutUsOptions(title: "Email", icon: UIImage(systemName: "envelope"), iconBackground: .systemBlue, handler: {
                self.delegate?.sendEmail()
            }),
            AboutUsOptions(title: "Phone", icon: UIImage(systemName: "phone"), iconBackground: .systemRed, handler: {
                self.delegate?.phoneCall()
            }),
            AboutUsOptions(title: "Turnieranmledung", icon: UIImage(systemName: "rectangle.and.pencil.and.ellipsis"), iconBackground: .systemYellow, handler: {
                self.delegate?.openURL(withURL: StaticURL.Constants.turnieranmledungURL)
            }),
            AboutUsOptions(title: "Sommercamp – Anmeldung", icon: UIImage(systemName: "calendar.badge.plus"), iconBackground: .systemYellow, handler: {
                self.delegate?.openURL(withURL: StaticURL.Constants.sommercampAnmeldungURL)
            }),
            
        ]))
        
        models.append(AboutUsSection(tittle: "Social Media", options: [
            AboutUsOptions(title: "Facebook", icon: UIImage(systemName: "f.circle"), iconBackground: .systemBlue, handler: {
                self.delegate?.openURL(withURL: StaticURL.Constants.facebookURL)
            }),
            AboutUsOptions(title: "Instagram", icon: UIImage(systemName: "camera.circle"), iconBackground: .systemOrange, handler: {
                self.delegate?.openURL(withURL: StaticURL.Constants.instagramURL)
            }),
            AboutUsOptions(title: "X", icon: UIImage(systemName: "xmark"), iconBackground: .systemYellow, handler: {
                self.delegate?.openURL(withURL: StaticURL.Constants.xURL)
            }),
            AboutUsOptions(title: "Youtube", icon: UIImage(systemName: "play.circle"), iconBackground: .systemOrange, handler: {
                self.delegate?.openURL(withURL: StaticURL.Constants.youtubeURL)
            }),
        ]))
    }
}
