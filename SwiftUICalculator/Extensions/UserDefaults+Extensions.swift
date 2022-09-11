//
//  UserDefaults+Extensions.swift
//  SwiftUICalculator
//
//  Created by Karen Nikoghosyan on 08/09/2022.
//

import Foundation

extension UserDefaults {
    func setIsNight(value: Bool) {
        set(value, forKey: UserDefaultsKeys.isNight.rawValue)
    }
    
    func getIsNight() -> Bool {
        return bool(forKey: UserDefaultsKeys.isNight.rawValue)
    }
}

enum UserDefaultsKeys: String {
    case isNight
}
