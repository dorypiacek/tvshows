//
//  Endpoint.swift
//  TV Shows
//
//  Created by Dorota Piačeková on 04/08/2020.
//  Copyright © 2020 Dorota Piačeková. All rights reserved.
//

import Foundation
import Alamofire

/// Information about each endpoint used in the app.
enum Endpoint {
    case login
    case list
	case detail(String)
	case episodes(String)
	case image(String)

	// MARK: - Public properties

	/// Combination of base URL and path used for API calls
	var url: URLConvertible {
		Configuration.baseUrl + path
    }

	/// HTTP method that is used to call a specific endpoint
	var method: HTTPMethod {
		switch self {
		case .login:
			return .post
		default:
			return .get
		}
	}

	/// HTTP headers to be used in URL request
	var headers: HTTPHeaders {
		HTTPHeaders([acceptHeader, contentTypeHeader])
	}
}

// MARK: - Private properties

private extension Endpoint {
    var path: String {
        switch self {
        case .login: return "api/users/sessions"
        case .list: return "api/shows"
		case .detail(let id): return "api/shows/\(id)"
		case .episodes(let id): return "api/shows/\(id)/episodes"
		case .image(let path): return path
        }
    }

    var contentTypeHeader: HTTPHeader {
		.contentType("application/json")
    }

	var acceptHeader: HTTPHeader {
		.accept("application/json")
    }
}
