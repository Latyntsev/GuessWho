//
//  DataAccessLayer.swift
//  GuessWho
//
//  Created by Oleksandr Latyntsev on 14/01/2025.
//

import Foundation
import os.log

private let logger = Logger.dataAccessLayer

actor DataAccessLayer: DataAccessLayerProtocol {
    let webService: WebServiceProtocol
    private var tasks: [String: Any] = [:]
    
    init(webService: WebServiceProtocol) {
        self.webService = webService
        logger.log("DataAccessLayer initialized")
    }
    
    func access<T>(
        key: String,
        function: @escaping () async throws -> T
    ) async throws -> T {
        logger.log("accessing \(key)")
        if let task = tasks[key] as? Task<T, Error> {
            logger.log("task \(key) is already running")
            return try await task.value
        }
        let task = Task {
            try await function()
        }
        tasks[key] = task
        logger.log("starting task \(key)")
        do {
            let data = try await task.value
            tasks[key] = nil
            return data
        } catch {
            tasks[key] = nil
            throw error
        }
    }

    func fetchUsers() async throws -> [User] {
        try await access(key: "fetchUsers") {
            try await self.webService.fetchUser()
        }
    }
}
