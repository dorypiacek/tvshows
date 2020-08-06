//
//  ShowsListDataProvider.swift
//  TV Shows
//
//  Created by Dorota Piačeková on 06/08/2020.
//  Copyright © 2020 Dorota Piačeková. All rights reserved.
//

import Foundation
import PromiseKit

protocol ShowsListDataProviderType {
	func loadShows() -> Promise<Data<[TVShow]>>
}

extension ApiDataProvider: ShowsListDataProviderType {
	func loadShows() -> Promise<Data<[TVShow]>> {
		get(from: .list)
	}
}
