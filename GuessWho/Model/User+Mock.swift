//
//  User+Mock.swift
//  GuessWho
//
//  Created by Oleksandr Latyntsev on 15/01/2025.
//

import Foundation

#if DEBUG
extension User {
    static func mock() -> User {
        .init(
            id: 1,
            email: "test@debug.com",
            password: "123456",
            name: "Oleksandr Usyk",
            role: "Boxer",
            avatar: "https://ichef.bbci.co.uk/ace/standard/2048/cpsprodpb/831B/production/_97736533_usyk.jpg",
            creationAt: "",
            updatedAt: ""
        )
    }
}
#endif
