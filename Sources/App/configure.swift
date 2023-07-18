//
//  configure.swift
//  EKRemoteConfig
//
//  Created by Emil Karimov on 18.07.2023
//  Copyright © 2023 Emil Karimov. All rights reserved.
//

import NIOSSL
import Fluent
import FluentPostgresDriver
import Vapor

// configures your application
public func configure(_ app: Application) async throws {

    app.routes.defaultMaxBodySize = "1mb"
    app.http.server.configuration.address = .hostname("0.0.0.0", port: Environment.get(.HTTP_PORT).flatMap(Int.init(_:)))
    app.http.server.configuration.port = Environment.get(.HTTP_PORT).flatMap(Int.init(_:)) ?? 8080

    try database(app)
    try migrations(app)
    try routes(app)


    let fileMiddleware = FileMiddleware(publicDirectory: app.directory.publicDirectory)
    app.middleware.use(fileMiddleware)


}
