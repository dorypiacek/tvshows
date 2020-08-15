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
	func loadShows() -> Promise<Data<[TVShow]>> {
		.init { resolver in
			resolver.fulfill(Data(data: [TVShow(id: "1", title: "Test Show", imageUrl: "", likesCount: 1)]))
		}
		//get(from: .list)
	}
}
