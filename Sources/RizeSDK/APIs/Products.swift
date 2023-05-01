//
// Products API
//
// Copyright 2023-Present Rize Money, Inc. All rights reserved.
//

import Foundation

internal struct Products {
	private let decoder = JSONDecoder()

	internal init() {
		self.decoder.dateDecodingStrategy = .formatted(Formatter.iso8601)
	}

	/// List retrieves a list of Products filtered by the given parameters
	/// - Parameter query: ProductListParams
	/// - Returns: ProductList
	internal func list(query: ProductListParams) async throws -> ProductList? {
		let params = query.encodeURLQueryItem
		guard let (_, data) = try await HTTPService().doRequest(method: "GET", path: "products", query: params, body: nil) as? (HTTPURLResponse, Data) else {
			return nil
		}
		return try self.decoder.decode(ProductList.self, from: data)
	}

	/// Get returns a single Product
	/// - Parameter uid: Product UID
	/// - Returns: Product
	internal func get(uid: String) async throws -> Product? {
		if uid.isEmpty {
			throw HTTPServiceError.invalidQueryParameters(description: "UID is required")
		}

		guard let (_, data) = try await HTTPService().doRequest(method: "GET", path: "products/\(uid)", query: nil, body: nil) as? (HTTPURLResponse, Data) else {
			return nil
		}
		return try self.decoder.decode(Product.self, from: data)
	}
}
