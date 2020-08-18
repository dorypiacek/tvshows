//
//  ShowDetailDataProvider.swift
//  TV Shows
//
//  Created by Dorota Piačeková on 08/08/2020.
//  Copyright © 2020 Dorota Piačeková. All rights reserved.
//

import Foundation
import PromiseKit

extension ApiDataProvider: ShowDetailDataProviderType {
	func showDetail(with id: TVShowId) -> Promise<Data<TVShowDetail>> {
		get(from: .detail(id))
	}

	func episodes(for id: TVShowId) -> Promise<Data<[TVShowEpisode]>> {
		get(from: .episodes(id))
	}
}
