//
//  ApiManager.swift
//  FC Kufstein
//
//  Created by Adnann Muratovic on 27.10.23.
//

import UIKit

final class ApiManager {
    
    static let shared = ApiManager()
    
    // Function to fetch and parse data from a custom URL into the specified struct
    func fetchData<T: Decodable>(from url: URL, into type: T.Type) async throws -> T {
        let (data, _) = try await URLSession.shared.data(from: url)
        return try JSONDecoder().decode(T.self, from: data)
    }
    
    // Function to fetch posts
    func getPosts() async throws -> [Post] {
        guard let url = URL(string: ApiURL.Constants.baseURL) else {
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

    // Function to fetch match info with error handling
    func fetchMatchInfo() async throws -> MetchInfo {
        do {
            return try await fetchData(from: ApiURL.Constants.mainTeamMatchURL, into: MetchInfo.self)
        } catch {
            throw NetworkError.decodingError
        }
    }

    // Function to fetch last game info with error handling
    func fetchLastGameInfo() async throws -> LastGameInfo {
        do {
            return try await fetchData(from: ApiURL.Constants.lastGameURL, into: LastGameInfo.self)
        } catch {
            throw NetworkError.decodingError
        }
    }
    
    // Function to fetch the main team table info with error handling
    func fetchMainTeamTableInfo() async throws -> League {
        do {
            return try await fetchData(from: ApiURL.Constants.mainTeamTableURL, into: League.self)
        } catch {
            throw NetworkError.decodingError
        }
    }
    
    // Function to fetch the juniors table info with error handling
    func fetchJuniorsTableInfo() async throws -> League {
        do {
            return try await fetchData(from: ApiURL.Constants.juniorsTableURL, into: League.self)
        } catch {
            throw NetworkError.decodingError
        }
    }
}

