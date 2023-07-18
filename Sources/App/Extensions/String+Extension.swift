//
//  String+Extension.swift
//  EKRemoteConfig
//
//  Created by Emil Karimov on 18.07.2023
//  Copyright © 2023 Emil Karimov. All rights reserved.
//

import Foundation

extension String {
    
    func toDate(style: String = "dd.MM.yyyy") -> Date? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = style
        dateFormatter.timeZone = TimeZone.current
        dateFormatter.locale = Locale.current
        return dateFormatter.date(from: self)
    }

//    let version1 = "1.1.4"
//    let version2 = "1.5.2"
//
//    if version1 < version2 {
//        print("Версия \(version1) старше, чем версия \(version2)")
//    } else if version1 > version2 {
//        print("Версия \(version1) новее, чем версия \(version2)")
//    } else {
//        print("Версия \(version1) и версия \(version2) одинаковы")
//    }

    func compareVersion(lhs: String, rhs: String) -> String {
        if lhs < rhs {
            print("Версия \(lhs) старше, чем версия \(rhs)")
        } else if lhs > rhs {
            print("Версия \(lhs) новее, чем версия \(rhs)")
        } else {
            print("Версия \(lhs) и версия \(rhs) одинаковы")
        }
        return ""
    }

}
