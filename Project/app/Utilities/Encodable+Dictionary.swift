//
//  Encodable+Dictionary.swift
//  TV Shows
//
//  Created by Dorota Piačeková on 04/08/2020.
//  Copyright © 2020 Dorota Piačeková. All rights reserved.
//

import Foundation

extension Encodable {
	var dictionary: [String: Any]? {
		guard let data = try? JSONEncoder().encode(self) else {
			return nil
		}
		return (try? JSONSerialization.jsonObject(with: data, options: .allowFragments)).flatMap { $0 as? [String: Any] }
	}
}
