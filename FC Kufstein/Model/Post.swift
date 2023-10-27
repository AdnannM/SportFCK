//
//  Post.swift
//  FC Kufstein
//
//  Created by Adnann Muratovic on 27.10.23.
//

import UIKit

struct Post: Codable {
    let id: Int
    let date: String
    let link: String
    let title: Title
    let jetpackFeaturedMediaURL: String
    
    struct Title: Codable {
        let rendered: String
    }
    
    private enum CodingKeys: String, CodingKey {
        case id
        case date
        case link
        case title
        case jetpackFeaturedMediaURL = "jetpack_featured_media_url"
    }
}
