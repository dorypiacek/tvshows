//
//  TVShowDetail.swift
//  TV Shows
//
//  Created by Dorota Piačeková on 08/08/2020.
//  Copyright © 2020 Dorota Piačeková. All rights reserved.
//

import Foundation

enum TVShowType: String, Decodable {
	case shows
}

struct TVShowDetail: Decodable {
	let id: TVShowId
	let	description: String?
	let imageUrl: String
	let likesCount: Int
	let title: String
	let type: TVShowType

	private enum CodingKeys: String, CodingKey {
		case id = "_id", description, imageUrl, likesCount, title, type
	}
}
