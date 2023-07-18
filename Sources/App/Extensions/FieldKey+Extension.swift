//
//  FieldKey+Extension.swift
//  EKRemoteConfig
//
//  Created by Emil Karimov on 18.07.2023
//  Copyright © 2023 Emil Karimov. All rights reserved.
//

import Fluent

extension FieldKey {

    // MARK: - Dates
    static var createdAt: Self { "created_at" }
    static var updatedAt: Self { "updated_at" }
    static var deletedAt: Self { "deleted_at" }

    static var application: Self { "application" }
    static var applicationId: Self { "application_id" }
    static var platform: Self { "platform" }
    static var version: Self { "version" }
    static var build: Self { "build" }

    static var key: Self { "key" }
    static var value: Self { "value" }

}

