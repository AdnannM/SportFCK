//
//  NewsFetcher.swift
//  FC Kufstein
//
//  Created by Adnann Muratovic on 30.10.23.
//

import UIKit

class NewsFetcher {
    static let shared = NewsFetcher()
    
    func fetchNews() async throws -> [Post] {
        let posts = try await ApiManager.shared.getPosts()
        return posts
    }

    func formatPosts(_ posts: [Post]) -> [Post] {
        var formattedPosts = [Post]()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
        let outputFormatter = DateFormatter()
        outputFormatter.dateFormat = "MMM dd, yyyy"

        for post in posts {
            if let date = dateFormatter.date(from: post.date) {
                let formattedDate = outputFormatter.string(from: date)
                let formattedPost = Post(id: post.id, date: formattedDate, link: post.link, title: post.title, jetpackFeaturedMediaURL: post.jetpackFeaturedMediaURL)
                formattedPosts.append(formattedPost)
            } else {
                print("Error formatting date for post ID \(post.id)")
            }
        }
        return formattedPosts
    }
}
