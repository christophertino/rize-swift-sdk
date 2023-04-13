//
// HTTPService
//
// Copyright 2023-Present Rize Money, Inc. All rights reserved.
//

import Foundation

/// Provides methods for making HTTP requests
public struct HTTPService {
	/// Make the API request and return a response. Checks for valid auth token.
	public static func doRequest(method: String, path: String, query: String?, body: Data?, completion: @escaping (Result<Data, HTTPServiceError>) -> Void) {
		let headers = [
			"Accept": "application/json",
			"Content-Type": "application/json",
			"User-Agent": RizeSDK.config!.userAgent,
			"Authorization": ""
		]
		let url = URL(string: String(format: "%@/%@/%@", RizeSDK.config!.baseURL!, Constants().BASE_PATH, path))
		var request = URLRequest(url: url!)
		request.httpMethod = method
		request.allHTTPHeaderFields = headers
		request.httpBody = body

		URLSession.shared.dataTask(with: request, completionHandler: { (data, response, error) -> Void in
			if let data = data {
				completion(.success(data))
			} else if let error = error {
				completion(.failure(error as! HTTPServiceError))
			}
		}).resume()
	}
}

/// Custom error for HTTPService
public enum HTTPServiceError: Error {
	case apiError
	case decodeError
	case invalidEndpoint
	case invalidResponse
}
