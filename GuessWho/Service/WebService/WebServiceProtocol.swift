//
//  WebServiceProtocol.swift
//  GuessWho
//
//  Created by Oleksandr Latyntsev on 14/01/2025.
//

import Foundation

protocol WebServiceProtocol {
    func request<T: Codable>(
        method: HTTPMethod,
        path: String,
        queryItems: [String: String],
        headers: [String: String],
        body: Data?
    ) async throws -> T
}

extension WebServiceProtocol {
    func get<T: Codable>(
        path: String,
        queryItems: [String: String] = [:],
        headers: [String: String] = [:]
    ) async throws -> T {
        try await request(method: .get, path: path, queryItems: queryItems, headers: headers, body: nil)
    }
    
    func post<T: Codable>(
        path: String,
        queryItems: [String: String] = [:],
        body: Data? = nil,
        headers: [String: String] = [:]
    ) async throws -> T {
        try await request(method: .post, path: path, queryItems: queryItems, headers: headers, body: body)
    }
}
