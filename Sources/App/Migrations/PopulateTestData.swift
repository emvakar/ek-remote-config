//
//  PopulateTestData.swift
//  EKRemoteConfig
//
//  Created by Emil Karimov on 18.07.2023
//  Copyright © 2023 Emil Karimov. All rights reserved.
//

import Fluent
import SQLKit

struct PopulateTestData: AsyncMigration {

    func prepare(on database: Database) async throws {

        let demoData1 = Settings(platform: .ios, application: "tests", version: "1.0.0", key: "test_key", value: false)
        let demoData2 = Settings(platform: .ios, application: "tests", version: "1.0.3", key: "test_key", value: true)
        let demoData3 = Settings(platform: .ios, application: "tests", version: "1.0.9", key: "test_key", value: false)
        let demoData4 = Settings(platform: .ios, application: "tests", version: "1.1.1", key: "test_key", value: true)

        try await demoData1.save(on: database)
        try await demoData2.save(on: database)
        try await demoData3.save(on: database)
        try await demoData4.save(on: database)

    }

    func revert(on database: Database) async throws {
        try await database.schema(Settings.schema).delete()
    }

}

