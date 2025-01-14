//
//  User.swift
//  GuessWho
//
//  Created by Oleksandr Latyntsev on 14/01/2025.
//

import Foundation

struct User: Codable {
    let id: Int
    let email: String
    let password: String
    let name: String
    let role: String
    let avatar: String
    let creationAt: String
    let updatedAt: String
}
