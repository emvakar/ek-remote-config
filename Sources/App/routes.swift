//
//  routes.swift
//  EKRemoteConfig
//
//  Created by Emil Karimov on 18.07.2023
//  Copyright © 2023 Emil Karimov. All rights reserved.
//

import Fluent
import Vapor

func routes(_ app: Application) throws {

    let controllers: [RouteCollection] =
    [
        SettingsController(),
    ]

    for controller in controllers {
        try app.routes.register(collection: controller)
    }

}
