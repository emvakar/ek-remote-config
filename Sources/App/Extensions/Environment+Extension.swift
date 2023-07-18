//
//  Environment+Extension.swift
//  EKRemoteConfig
//
//  Created by Emil Karimov on 18.07.2023
//  Copyright © 2023 Emil Karimov. All rights reserved.
//

import Vapor

enum EnvKeys: String {

    case HTTP_PORT
    case HTTP_HOSTNAME
    case DATABASE_HOSTNAME
    case DATABASE_PORT
    case DATABASE_USERNAME
    case DATABASE_NAME
    case DATABASE_PASSWORD

}

extension Environment {
    
    static func get(_ key: EnvKeys) -> String? {
        return Environment.get(key.rawValue)
    }
    
}
