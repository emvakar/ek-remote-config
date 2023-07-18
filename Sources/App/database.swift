//
//  database.swift
//  EKRemoteConfig
//
//  Created by Emil Karimov on 18.07.2023
//  Copyright © 2023 Emil Karimov. All rights reserved.
//

import Vapor
import FluentPostgresDriver
import PostgresKit

func database(_ app: Application) throws {

    let dbCofig = SQLPostgresConfiguration(hostname: Environment.get(.DATABASE_HOSTNAME) ?? "localhost",
                                           port: Environment.get(.DATABASE_PORT).flatMap(Int.init(_:)) ?? SQLPostgresConfiguration.ianaPortNumber,
                                           username: Environment.get(.DATABASE_USERNAME) ?? "vapor",
                                           password: Environment.get(.DATABASE_PASSWORD) ?? "vapor",
                                           database: Environment.get(.DATABASE_NAME) ?? "vapor",
                                           tls: .disable)

    let factory = DatabaseConfigurationFactory.postgres(configuration: dbCofig, sqlLogLevel: .error)

    app.databases.use(factory, as: .psql, isDefault: true)

    app.databases.middleware.use(SettingsModelMiddleware())

}
