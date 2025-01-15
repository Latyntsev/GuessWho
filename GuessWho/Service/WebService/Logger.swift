//
//  Logger.swift
//  GuessWho
//
//  Created by Oleksandr Latyntsev on 14/01/2025.
//

import Foundation
import os.log

extension Logger {
    static let subsystem = Bundle.main.bundleIdentifier!
    
    static let webService = Logger(subsystem: subsystem, category: "webService")
    static let dataAccessLayer = Logger(subsystem: subsystem, category: "dataAccessLayer")
}
