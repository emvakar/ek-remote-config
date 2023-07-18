//
//  Platform.swift
//  EKRemoteConfig
//
//  Created by Emil Karimov on 18.07.2023
//  Copyright © 2023 Emil Karimov. All rights reserved.
//

import Vapor
import Fluent

enum Platform: String, Content, Codable, CaseIterable {

    static let schema = "platforms"

    case ios
    case android
    case macos
    case windows
    case server
    case all

}
