//
//  LocalizationKit.swift
//  TV Shows
//
//  Created by Dorota Piačeková on 04/08/2020.
//  Copyright © 2020 Dorota Piačeková. All rights reserved.
//

import Foundation

struct LocalizationKit {
	static let login = Login()
	static let general = General()
}

extension LocalizationKit {
	struct General {
		let ok = "Ok"
		let errorTitle = "Something went wrong."
	}

	struct Login {
		let emailPlaceholder = "Email"
		let passwordPlaceholder = "Password"
		let radioButtonTitle = "Remember me"
		let loginButtonTitle = "LOG IN"
	}
}
