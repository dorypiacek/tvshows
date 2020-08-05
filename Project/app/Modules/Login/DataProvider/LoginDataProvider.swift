//
//  LoginDataProvider.swift
//  TV Shows
//
//  Created by Dorota Piačeková on 04/08/2020.
//  Copyright © 2020 Dorota Piačeková. All rights reserved.
//

import Foundation
import PromiseKit

protocol LoginDataProviderType {
	func login(with credentials: UserCredentials) -> Promise<Data<LoginResponse>>
}

extension ApiDataProvider: LoginDataProviderType {
	func login(with credentials: UserCredentials) -> Promise<Data<LoginResponse>> {
		load(from: .login, body: credentials)
	}
}
