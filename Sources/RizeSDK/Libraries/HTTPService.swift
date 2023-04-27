//
// HTTPService
//
// Copyright 2023-Present Rize Money, Inc. All rights reserved.
//

import Foundation

/// Custom error for HTTPService
public enum HTTPServiceError: Error {
	case apiError(description: String?)
	case jsonDecoderError(description: String?)
	case invalidURL(description: String?)
	case invalidEndpoint(description: String?)
	case invalidResponse(description: String?)
	case invalidQueryParameters(description: String?)
	case invalidBodyParameters(description: String?)
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
	internal func doRequest(method: String, path: String, query: [URLQueryItem]?, body: Data?) async throws -> (HTTPURLResponse?, Data?) {
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

		if RizeSDK.config?.environment == RizeEnvironments.local {
			components.scheme = "http"
			components.host = "0.0.0.0"
			components.port = 4010
			components.path = String(format: "/%@", path)
			Utils.logger("Request url: \(components.url!)")
		}

		guard let url = components.url else{
			throw HTTPServiceError.invalidURL(description: "Invalid URLComponents.url")
		}
		var request = URLRequest(url: url)
		request.httpMethod = method
		request.allHTTPHeaderFields = headers
		request.httpBody = body

		let (data, response) = try await URLSession.shared.data(for: request)
		guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode >= 200, httpResponse.statusCode < 400 else {
			guard let err = try? JSONDecoder().decode(RizeAPIError.self, from: data) else {
				// Error format does not match RizeAPIError
				throw HTTPServiceError.invalidEndpoint(description: String(data: data, encoding: String.Encoding.utf8))
			}
			throw HTTPServiceError.invalidResponse(description: "\(err)")
		}

		return (response as? HTTPURLResponse, data)
	}
}
