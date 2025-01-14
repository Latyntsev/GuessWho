//
//  WebService.swift
//  GuessWho
//
//  Created by Oleksandr Latyntsev on 14/01/2025.
//

import Foundation

extension WebService {
    enum Error: Swift.Error {
        case invalidURL
    }
}

class WebService: WebServiceProtocol {
    let baseURL: String
    let session: URLSession

    init(
        baseURL: String = Config.baseURL,
        session: URLSession = URLSession.shared
    ) {
        self.baseURL = baseURL
        self.session = session
    }
    
    func request<T: Codable>(
        urlConfigurator: (inout URLComponents) -> Void,
        requestConfigurator: (inout URLRequest) -> Void
    ) async throws -> T {
        guard var urlComponents = URLComponents(string: baseURL) else {
            throw Error.invalidURL
        }
        urlConfigurator(&urlComponents)
        guard let url = urlComponents.url else {
            throw Error.invalidURL
        }
        
        var request = URLRequest(url: url)
        requestConfigurator(&request)
        let (data, _) = try await URLSession.shared.data(for: request)
        let response = try JSONDecoder().decode(T.self, from: data)
        return response
    }
    
    func request<T: Codable>(
        method: HTTPMethod,
        path: String,
        queryItems: [String: String],
        headers: [String: String],
        body: Data?
    ) async throws -> T {
        try await request { urlComponents in
            urlComponents.path = path
            urlComponents.queryItems = queryItems.map { URLQueryItem(name: $0.key, value: $0.value) }
        }
        requestConfigurator: { request in
            request.httpMethod = method.rawValue
            request.httpBody = body
            headers.forEach { request.setValue($0.value, forHTTPHeaderField: $0.key) }
        }
    }
}
