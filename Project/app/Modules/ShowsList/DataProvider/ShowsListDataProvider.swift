//
//  ShowsListDataProvider.swift
//  TV Shows
//
//  Created by Dorota Piačeková on 06/08/2020.
//  Copyright © 2020 Dorota Piačeková. All rights reserved.
//

import Foundation
import PromiseKit

extension ApiDataProvider: ShowsListDataProviderType {
	/// Gets list of TV Shows
	func loadShows() -> Promise<Data<[TVShow]>> {
		get(from: .list)
	}
}
