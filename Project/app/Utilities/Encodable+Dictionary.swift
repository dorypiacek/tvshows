//
//  Encodable+Dictionary.swift
//  TV Shows
//
//  Created by Dorota Piačeková on 04/08/2020.
//  Copyright © 2020 Dorota Piačeková. All rights reserved.
//

import Foundation

extension Encodable {
	/// Creates a dictionary from any struct conforming to Encodable protocol.
	var dictionary: [String: Any]? {
		guard let data = try? JSONEncoder().encode(self) else {
			return nil
		}

		let json = try? JSONSerialization.jsonObject(with: data, options: .allowFragments)
		return json.flatMap { $0 as? [String: Any] }
	}
}
