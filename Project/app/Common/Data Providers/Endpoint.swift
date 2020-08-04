//
//  Endpoint.swift
//  TV Shows
//
//  Created by Dorota Piačeková on 04/08/2020.
//  Copyright © 2020 Dorota Piačeková. All rights reserved.
//

import Foundation
import Alamofire

enum Endpoint {
    case login
    case list
	case detail(String)

    var path: String {
        switch self {
        case .login: return "api/users/sessions"
        case .list: return "api/shows"
		case .detail(let id): return "api/shows/\(id)"
        }
    }

	var method: HTTPMethod {
		switch self {
		case .login:
			return .post
		default:
			return .get
		}
	}

	var headers: HTTPHeaders {
		var headers = [acceptHeader, contentTypeHeader]
		if let authorization = authorizationHeader {
			headers.append(authorization)
		}
		return HTTPHeaders(headers)
	}

    private var contentTypeHeader: HTTPHeader {
		HTTPHeader(name: "Content-Type", value: "application/json")
    }

	private var acceptHeader: HTTPHeader {
		HTTPHeader(name: "Accept", value: "application/json")
    }

	private var authorizationHeader: HTTPHeader? {
		switch self.authorization {
		case .none:
			return nil
		case .basic:
			return HTTPHeader(name: "Authorization", value: "")
		}
	}
}

extension Endpoint {
    enum Authorization {
        case none, basic
    }

    var authorization: Authorization {
        switch self {
		case .login:
			return .none
		default:
			return .basic
        }
    }
}

extension Endpoint {
    var base: String {
		"https://api.infinum.academy/"
	}

    var url: URLConvertible {
        base + path
    }
}
