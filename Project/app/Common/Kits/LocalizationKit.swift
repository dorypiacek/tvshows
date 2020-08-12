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
	static let showsList = ShowsList()
	static let showDetail = ShowDetail()
}

extension LocalizationKit {
	struct General {
		let ok = "Ok"
		let errorTitle = "Error"
		let errorMessage = "Something went wrong. Please try again later."
		let noInternetErrorTitle = "No internet"
		let noInternetErrorMessage = "Please connect to network and try again."
		let loading = "Loading..."
		let tryAgain = "Try again"
	}

	struct Login {
		let emailPlaceholder = "Email"
		let passwordPlaceholder = "Password"
		let radioButtonTitle = "Remember me"
		let loginButtonTitle = "LOG IN"
	}

	struct ShowsList {
		let title = "Shows"
	}

	struct ShowDetail {
		let title = "Episodes"
	}
}
