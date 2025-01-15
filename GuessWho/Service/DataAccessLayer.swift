//
//  DataAccessLayer.swift
//  GuessWho
//
//  Created by Oleksandr Latyntsev on 14/01/2025.
//

import Foundation
import os.log

private let logger = Logger.dataAccessLayer

actor DataAccessLayer {
    let webService: WebService
    private var tasks: [String: Any] = [:]
    
    init(webService: WebService) {
        self.webService = webService
        logger.log("DataAccessLayer initialized")
    }
    
    func access<T>(
        key: String,
        function: @escaping () async throws -> T
    ) async throws -> T {
        logger.log("accessing \(key)")
        if let task = tasks[key] as? Task<T, Error> {
            tasks[key] = nil
            logger.log("task \(key) is already running")
            return try await task.value
        }
        let task = Task {
            try await function()
        }
        tasks[key] = task
        logger.log("starting task \(key)")
        return try await task.value
    }
        
    
    func fetchUsers() async throws -> [User] {
        try await access(key: "fetchUsers") {
            try await self.webService.fetchUser()
        }
    }
}
