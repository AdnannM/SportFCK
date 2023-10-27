//
//  NetworkError.swift
//  FC Kufstein
//
//  Created by Adnann Muratovic on 27.10.23.
//

import Foundation

enum NetworkError: Error {
    case invalidURL
    case requestFailed
    case invalidResponse
    case decodingError
}
