//
//  ApiDataProvider.swift
//  TV Shows
//
//  Created by Dorota Piačeková on 04/08/2020.
//  Copyright © 2020 Dorota Piačeková. All rights reserved.
//

import Foundation
import Alamofire
import PromiseKit

class ApiDataProvider {
	func load<ResultType: Decodable, BodyType: Encodable>(from endpoint: Endpoint, body: BodyType? = nil) -> Promise<ResultType> {
		Promise { resolver in
			let method = endpoint.method
			let url = endpoint.url
			let headers = endpoint.headers
			let params = body?.dictionary

			AF.request(url, method: method, parameters: method == .get ? nil : params, encoding: JSONEncoding.default, headers: headers).responseJSON { (response) in
				switch response.result {
				case .success(let data):
					guard let data = data as? ResultType else {
						return resolver.reject(AFError.responseValidationFailed(reason: .dataFileNil))
					}
					resolver.fulfill(data)
				case .failure(let error):
					resolver.reject(error)
				}
			}
		}
    }
}
