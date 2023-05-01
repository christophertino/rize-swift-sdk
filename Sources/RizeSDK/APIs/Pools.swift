//
// Pools API
//
// Copyright 2023-Present Rize Money, Inc. All rights reserved.
//

import Foundation

internal struct Pools {
	private let decoder = JSONDecoder()

	internal init() {
		self.decoder.dateDecodingStrategy = .formatted(Formatter.iso8601)
	}

	/// List retrieves a list of Pools filtered by the given parameters
	/// - Parameter query: PoolListParams
	/// - Returns: PoolList
	internal func list(query: PoolListParams) async throws -> PoolList? {
		let params = query.encodeURLQueryItem
		guard let (_, data) = try await HTTPService().doRequest(method: "GET", path: "pools", query: params, body: nil) as? (HTTPURLResponse, Data) else {
			return nil
		}
		return try self.decoder.decode(PoolList.self, from: data)
	}

	/// Get returns a single Pool
	/// - Parameter uid: Pool UID
	/// - Returns: Pool
	internal func get(uid: String) async throws -> Pool? {
		if uid.isEmpty {
			throw HTTPServiceError.invalidQueryParameters(description: "UID is required")
		}

		guard let (_, data) = try await HTTPService().doRequest(method: "GET", path: "pools/\(uid)", query: nil, body: nil) as? (HTTPURLResponse, Data) else {
			return nil
		}
		return try self.decoder.decode(Pool.self, from: data)
	}
}
