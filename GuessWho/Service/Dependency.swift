//
//  Dependency.swift
//  GuessWho
//
//  Created by Oleksandr Latyntsev on 14/01/2025.
//

import Foundation

var DI = Dependency()

struct Dependency {
    let webService: WebServiceProtocol
    let dataAccessLayer: DataAccessLayerProtocol
        
    init() {
        let webService = WebService()
        self.webService = webService
        dataAccessLayer = DataAccessLayer(webService: webService)
    }
}
