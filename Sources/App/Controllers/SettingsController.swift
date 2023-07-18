//
//  SettingsController.swift
//  EKRemoteConfig
//
//  Created by Emil Karimov on 18.07.2023
//  Copyright © 2023 Emil Karimov. All rights reserved.
//

import Vapor
import Fluent

struct SettingsController: RouteCollection {
    
    func boot(routes: RoutesBuilder) throws {
        let remote = routes.grouped("api", "v1", "remote")
        remote.get(use: index)
    }
    
    func index(_ req: Request) async throws -> [Settings.Public] {
        guard
            let platformString = req.headers.first(name: "platform")?.lowercased(),
            let platform = Platform(rawValue: platformString),
            let applicationName = req.headers.first(name: "app"),
            let version = req.headers.first(name: "version")
        else {
            throw Abort(.badRequest, reason: "Your request is not possible!")
        }
        let settings = try await Settings.byFilter(on: req.db, application: applicationName, platform: platform, version: version).compactMap({ Settings.Public(setting: $0) })
        return settings
    }
    
}
