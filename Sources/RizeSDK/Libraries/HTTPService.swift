//
// HTTPService
//
// Copyright 2023-Present Rize Money, Inc. All rights reserved.
//

import Foundation

/// Custom error for HTTPService
public enum HTTPServiceError: Error {
	case apiError
	case decodeError
	case invalidEndpoint
	case invalidResponse
}

/// Default API error type
internal struct RizeAPIError: Decodable {
	let errors: [ErrorDetails]
	let status: Int
}

/// Error detail JSON
internal struct ErrorDetails: Decodable {
	let code: Int
	let title, detail, occurredAt: String

	enum CodingKeys: String, CodingKey {
		case code, title, detail
		case occurredAt = "occurred_at"
	}
}

/// Provides methods for making HTTP requests
internal struct HTTPService {
	/// Make the API request and return response data
	internal func doRequest(method: String, path: String, query: [URLQueryItem]?, body: Data?) async throws -> Data {
		// Check for valid auth token and refresh if necessary
		if path != "auth" {
			_ = try await Auth().getToken()
		}

		let headers = [
			"Accept": "application/json",
			"Content-Type": "application/json",
			"User-Agent": RizeSDK.config!.userAgent,
			"Authorization": TokenCache.shared.token ?? ""
		]

		var components = URLComponents()
		components.scheme = "https"
		components.host = RizeSDK.config!.baseURL
		components.path = String(format: "%@/%@", Constants().basePath, path)
		components.queryItems = query

		var request = URLRequest(url: components.url!)
		request.httpMethod = method
		request.allHTTPHeaderFields = headers
		request.httpBody = body

		let (data, response) = try await URLSession.shared.data(for: request)
		guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode >= 200, httpResponse.statusCode < 400 else {
			let err = try? JSONDecoder().decode(RizeAPIError.self, from: data)
			Utils.logger("doRequest error response:\n \(String(describing: err))")
			throw HTTPServiceError.invalidResponse
		}

		return data
	}
}
