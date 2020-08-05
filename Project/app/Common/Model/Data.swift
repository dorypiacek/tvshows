//
//  Data.swift
//  TV Shows
//
//  Created by Dorota Piačeková on 04/08/2020.
//  Copyright © 2020 Dorota Piačeková. All rights reserved.
//

import Foundation

struct Data<T: Decodable>: Decodable {
	let data: T
}
