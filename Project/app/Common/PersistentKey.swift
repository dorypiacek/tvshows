//
//  UserDefaultsKey.swift
//  TV Shows
//
//  Created by Dorota Piačeková on 04/08/2020.
//  Copyright © 2020 Dorota Piačeková. All rights reserved.
//

import Foundation

/// A key used for saving and retrieving persistent values from Keychain or UserDefaults
enum PersistentKey: String, CustomStringConvertible {
    case accessToken
	case userCredentials

    var description: String {
		self.rawValue
    }
}
