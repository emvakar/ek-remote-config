//
//  migartions.swift
//  EKRemoteConfig
//
//  Created by Emil Karimov on 18.07.2023
//  Copyright © 2023 Emil Karimov. All rights reserved.
//

import Vapor
import FluentPostgresDriver

func migrations(_ app: Application) throws {

    let isTestRunning = app.environment == .testing

    if isTestRunning, let postgres = app.db as? PostgresDatabase {
        try app.autoRevert().wait()
        _ = try postgres.simpleQuery("drop schema public cascade").wait()
        _ = try postgres.simpleQuery("create schema public").wait()

    }

    app.migrations.add(CreatePlatforms())
    app.migrations.add(CreateSettings())

    if isTestRunning {
        app.migrations.add(PopulateTestData())
    }

    try app.autoMigrate().wait()

}

