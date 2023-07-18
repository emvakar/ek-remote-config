//
//  Settings.swift
//  EKRemoteConfig
//
//  Created by Emil Karimov on 18.07.2023
//  Copyright © 2023 Emil Karimov. All rights reserved.
//

import Vapor
import Fluent
import UniqueID

final class SettingsModelMiddleware: AsyncModelMiddleware {

    typealias Model = Settings

    func create(model: Model, on db: Database, next: AnyAsyncModelResponder) async throws {
        if let uuid = UUID(uuidString: UniqueID.timeOrdered().serialized(lowercase: true, separators: true)), model.id == nil {
            model.id = uuid
        }
        try await next.create(model, on: db)
    }

}

final class Settings: Model, Content {

    static func byFilter(on db: Database, application: String, platform: Platform, version: String) async throws -> [Settings] {
        
        let query = try await Settings.query(on: db)
            .filter(\.$application, .equal, application)
            .filter(\.$platform, .equal, platform)
            .filter(\.$version, .lessThanOrEqual, version)
            .sort(\.$version, .descending)
            .all()

        var uniqueSettings: [Settings] = []
        var uniqueKeys: Set<String> = []

        for setting in query {
            guard !uniqueKeys.contains(setting.key) else {
                continue
            }

            uniqueSettings.append(setting)
            uniqueKeys.insert(setting.key)
        }

        return uniqueSettings
    }

    static let schema = "settings"

    @ID()
    var id: UUID?

    @Enum(key: .platform)
    var platform: Platform

    @Field(key: .application)
    var application: String

    @Field(key: .version)
    var version: String

    @Field(key: .key)
    var key: String

    @Field(key: .value)
    var value: Bool

    @Timestamp(key: .createdAt, on: .create)
    var createdAt: Date?

    @Timestamp(key: .updatedAt, on: .update)
    var updatedAt: Date?

    @Timestamp(key: .deletedAt, on: .delete)
    var deletedAt: Date?

    init() { }

    init(id: UUID? = nil, platform: Platform, application: String, version: String, key: String, value: Bool) {
        self.id = id
        self.platform = platform
        self.application = application
        self.version = version
        self.key = key
        self.value = value
    }

    struct Public: Content {

        let version: String
        let key: String
        let value: Bool

        init(setting: Settings) {
            self.version = setting.version
            self.key = setting.key
            self.value = setting.value
        }

    }

}
