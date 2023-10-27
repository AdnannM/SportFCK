//
//  ApiManager.swift
//  FC Kufstein
//
//  Created by Adnann Muratovic on 27.10.23.
//

import UIKit

class ApiManager {
    
    static let shared = ApiManager()
    
    private let baseURL = "https://fc-kufstein.at/wp-json/wp/v2/posts"
    
    // Function to fetch posts
    func getPosts() async throws -> [Post] {
        guard let url = URL(string: baseURL) else {
            throw NetworkError.invalidURL
        }
        
        let (data, _) = try await URLSession.shared.data(from: url)
        
        do {
            let posts = try JSONDecoder().decode([Post].self, from: data)
            return posts
        } catch {
            throw NetworkError.decodingError
        }
    }
}
