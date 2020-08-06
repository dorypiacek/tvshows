//
//  TVShow.swift
//  TV Shows
//
//  Created by Dorota Piačeková on 06/08/2020.
//  Copyright © 2020 Dorota Piačeková. All rights reserved.
//

import Foundation

typealias TVShowId = String

struct TVShow: Decodable {
	let id: TVShowId
	let title: String
	let imageUrl: String
	let likesCount: Int

	private enum CodingKeys: String, CodingKey {
		case id = "_id", title, imageUrl, likesCount
	}
}
