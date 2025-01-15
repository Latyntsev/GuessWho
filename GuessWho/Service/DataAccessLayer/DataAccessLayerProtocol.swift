//
//  DataAccessLayerProtocol.swift
//  GuessWho
//
//  Created by Oleksandr Latyntsev on 15/01/2025.
//

import Foundation

protocol DataAccessLayerProtocol {
    func fetchUsers() async throws -> [User]
}
