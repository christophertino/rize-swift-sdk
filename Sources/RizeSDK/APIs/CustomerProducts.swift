//
// Customer Products API
//
// Copyright 2023-Present Rize Money, Inc. All rights reserved.
//

import Foundation

internal struct CustomerProducts {
	private let decoder = JSONDecoder()

	internal init() {
		self.decoder.dateDecodingStrategy = .formatted(Formatter.iso8601)
	}

	/// List Customers and the Products they have onboarded onto, filtered by the given parameters
	/// - Parameter query: CustomerProductListParams
	/// - Returns: CustomerProductList
	internal func list(query: CustomerProductListParams) async throws -> CustomerProductList? {
		let params = query.encodeURLQueryItem
		guard let (_, data) = try await HTTPService().doRequest(method: "GET", path: "customer_products", query: params, body: nil) as? (HTTPURLResponse, Data) else {
			return nil
		}
		return try self.decoder.decode(CustomerProductList.self, from: data)
	}

	/// Create will submit a request to onboard a Customer onto a new product
	/// - Parameter body: CustomerProductCreateParams
	/// - Returns: CustomerProduct
	internal func create(body: CustomerProductCreateParams) async throws -> CustomerProduct? {
		if body.customer_uid.isEmpty || body.product_uid.isEmpty {
			throw HTTPServiceError.invalidBodyParameters(description: "customer_uid and product_uid are required")
		}

		let params = try JSONEncoder().encode(body)
		guard let (_, data) = try await HTTPService().doRequest(method: "POST", path: "customer_products", query: nil, body: params) as? (HTTPURLResponse, Data) else {
			return nil
		}
		return try self.decoder.decode(CustomerProduct.self, from: data)
	}

	/// Get a single Customer Product
	/// - Parameter uid: Customer Product UID
	/// - Returns: CustomerProduct
	internal func get(uid: String) async throws -> CustomerProduct? {
		if uid.isEmpty {
			throw HTTPServiceError.invalidQueryParameters(description: "UID is required")
		}

		guard let (_, data) = try await HTTPService().doRequest(method: "GET", path: "customer_products/\(uid)", query: nil, body: nil) as? (HTTPURLResponse, Data) else {
			return nil
		}
		return try self.decoder.decode(CustomerProduct.self, from: data)
	}
}
