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
	/// Gets TV Show detail for given ID
	/// - Parameter id: TV show ID
	func showDetail(with id: TVShowId) -> Promise<Data<TVShowDetail>> {
		get(from: .detail(id))
	}

	/// Gets TV Show episodes for given ID
	/// - Parameter id: TV show ID
	func episodes(for id: TVShowId) -> Promise<Data<[TVShowEpisode]>> {
		get(from: .episodes(id))
	}
}
