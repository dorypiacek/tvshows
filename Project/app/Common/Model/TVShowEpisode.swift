//
//  TVShowEpisode.swift
//  TV Shows
//
//  Created by Dorota Piačeková on 08/08/2020.
//  Copyright © 2020 Dorota Piačeková. All rights reserved.
//

import Foundation

typealias EpisodeId = String

struct TVShowEpisode: Decodable {
	let id: EpisodeId
	let title: String
	let description: String
	let imageUrl: String
	let episodeNumber: String
	let season: String

	private enum CodingKeys: String, CodingKey {
		case id = "_id", title, description, imageUrl, episodeNumber, season
	}
}
