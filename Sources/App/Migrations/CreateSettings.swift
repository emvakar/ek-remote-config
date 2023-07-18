//
//  CreateSettings.swift
//  EKRemoteConfig
//
//  Created by Emil Karimov on 18.07.2023
//  Copyright © 2023 Emil Karimov. All rights reserved.
//

import Fluent
import SQLKit

struct CreateSettings: AsyncMigration {

    func prepare(on database: Database) async throws {

        let platformsType = try await database.enum(Platform.schema).read()
        let defaultValue = SQLColumnConstraintAlgorithm.default(Platform.server.rawValue)

        try await database.schema(Settings.schema)
            .id()
            .field(.platform, platformsType, .required, .sql(defaultValue))
            .field(.application, .string, .required)
            .field(.version, .string, .required)
            .field(.key, .string, .required)
            .field(.value, .bool, .required)
            .field(.createdAt, .datetime)
            .field(.updatedAt, .datetime)
            .field(.deletedAt, .datetime)
            .create()

    }

    func revert(on database: Database) async throws {
        try await database.schema(Settings.schema).delete()
    }

}
