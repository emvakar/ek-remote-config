//
//  CreatePlatforms.swift
//  EKRemoteConfig
//
//  Created by Emil Karimov on 18.07.2023
//  Copyright © 2023 Emil Karimov. All rights reserved.
//

import Fluent

struct CreatePlatforms: AsyncMigration {

    func prepare(on database: Database) async throws {
        var enumBuilder = database.enum(Platform.schema)
        for option in Platform.allCases {
            enumBuilder = enumBuilder.case(option.rawValue)
        }
        _ = try await enumBuilder.create()
    }

    func revert(on database: Database) async throws {
        try await database.schema(Platform.schema).delete()
    }

}
